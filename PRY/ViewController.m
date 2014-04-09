//
//  ViewController.m
//  PRY
//
//  Created by Josh Puckett on 2/19/14.
//  Copyright (c) 2014 Josh Puckett. All rights reserved.
//

#import "ViewController.h"
#import "QCPTProtocol.h"


@interface ViewController ()
@end

@implementation ViewController{
    __weak PTChannel *serverChannel_;
    __weak PTChannel *peerChannel_;
    double _pitch;
    double _roll;
    double _yaw;
    double _accXg;
    double _accYg;
    double _accZg;
    BOOL _orientation;
//    double touchX;
//    double touchY;
//    BOOL isTap;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _manager = [[CMMotionManager alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getValues:) userInfo:nil repeats:YES];
    
    self.manager.deviceMotionUpdateInterval = 0.05; // 20 Hz
    [self.manager startDeviceMotionUpdates];
    
    self.manager.accelerometerUpdateInterval = 0.05;  // 20 Hz
    [self.manager startAccelerometerUpdates];

    PTChannel *channel = [PTChannel channelWithDelegate:self];
    [channel listenOnPort:PTPortNumber IPv4Address:INADDR_LOOPBACK callback:^(NSError *error) {
        if (error) {
        } else {
            serverChannel_ = channel;
        }
    }];

    [self.view setMultipleTouchEnabled:YES];
//    touchX = 0;
//    touchY = 0;


}
/* This is a super crude first implementation of passing touch data to QC,
 however it's pretty poor, and needs to be entirely rewritten */

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touched = [[event allTouches] anyObject];
//    NSSet* myTouches=[event allTouches];
//    for(UITouch* touch in myTouches) {
//        CGPoint location = [touch locationInView:touched.view];
//        touchX = location.x;
//        touchY = location.y;
//        isTap = YES;
//    }
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touched = [[event allTouches] anyObject];
//    NSSet* myTouches=[event allTouches];
//    for(UITouch* touch in myTouches) {
//        CGPoint location = [touch locationInView:touched.view];
//        touchX = location.x;
//        touchY = location.y;
//        isTap = YES;
//                NSLog(@"x=%.2f y=%.2f", touchX, touchY);
//    }
//
//}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    isTap = NO;
//}





-(void) getValues:(NSTimer *) timer {
    UIDevice *device = [UIDevice currentDevice];


    _accXg = self.manager.accelerometerData.acceleration.x;
    _accYg = self.manager.accelerometerData.acceleration.y;
    _accZg = self.manager.accelerometerData.acceleration.z;


    _pitch = (180/M_PI)*self.manager.deviceMotion.attitude.pitch;
    _roll = (180/M_PI)*self.manager.deviceMotion.attitude.roll;
    _yaw = (180/M_PI)*self.manager.deviceMotion.attitude.yaw;
    _orientation = UIDeviceOrientationIsLandscape(device.orientation);



    _accX.text = [NSString stringWithFormat:@"%.2f",_accXg];
    _accY.text = [NSString stringWithFormat:@"%.2f",_accYg];
    _accZ.text = [NSString stringWithFormat:@"%.2f",_accZg];
    _pitchLabel.text = [NSString stringWithFormat:@"%.2f", _pitch];
    _rollLabel.text = [NSString stringWithFormat:@"%.2f", _roll];
    _yawLabel.text = [NSString stringWithFormat:@"%.2f",_yaw];


    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithBool:_orientation], @"Orientation",
                          [NSString stringWithFormat:@"%0.2f", _pitch], @"Pitch",
                          [NSString stringWithFormat:@"%0.2f", _roll], @"Roll",
                          [NSString stringWithFormat:@"%0.2f", _yaw], @"Yaw",
                          [NSString stringWithFormat:@"%.2f",_accXg], @"accX",
                          [NSString stringWithFormat:@"%.2f",_accYg], @"accY",
                          [NSString stringWithFormat:@"%.2f",_accZg], @"accZ",
//                          [NSString stringWithFormat:@"%0.2f", touchX], @"x",
//                          [NSString stringWithFormat:@"%0.2f", touchY], @"y",
//                          [NSNumber numberWithBool:isTap], @"tap",
                          nil];
    dispatch_data_t payload = [info createReferencingDispatchData];
    [peerChannel_ sendFrameOfType:QCInfo tag:PTFrameNoTag withPayload:payload callback:^(NSError *error) {
        if (error) {
            NSLog(@"Failed to send QCInfo: %@", error);
        }
    }];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}



- (void)viewDidUnload {
    if (serverChannel_) {
        [serverChannel_ close];
    }
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - PTChannelDelegate


- (void)ioFrameChannel:(PTChannel*)channel didReceiveFrameOfType:(uint32_t)type tag:(uint32_t)tag payload:(PTData*)payload {
    if (type == PTExampleFrameTypeTextMessage) {
        PTExampleTextFrame *textFrame = (PTExampleTextFrame*)payload.data;
        textFrame->length = ntohl(textFrame->length);
    } else if (type == PTExampleFrameTypePing && peerChannel_) {
        [peerChannel_ sendFrameOfType:PTExampleFrameTypePong tag:tag withPayload:nil callback:nil];
    }
}


- (void)ioFrameChannel:(PTChannel*)channel didAcceptConnection:(PTChannel*)otherChannel fromAddress:(PTAddress*)address {
    if (peerChannel_) {
        [peerChannel_ cancel];
    }
    peerChannel_ = otherChannel;
    peerChannel_.userInfo = address;
}

@end
