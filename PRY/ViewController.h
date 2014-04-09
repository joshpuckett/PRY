//
//  ViewController.h
//  PRY
//
//  Created by Josh Puckett on 2/19/14.
//  Copyright (c) 2014 Josh Puckett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "PTChannel.h"


@interface ViewController : UIViewController <PTChannelDelegate>

@property (strong,nonatomic) CMMotionManager *manager;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (weak, nonatomic) IBOutlet UILabel *rollLabel;
@property (weak, nonatomic) IBOutlet UILabel *yawLabel;

@property (weak, nonatomic) IBOutlet UILabel *accX;
@property (weak, nonatomic) IBOutlet UILabel *accY;
@property (weak, nonatomic) IBOutlet UILabel *accZ;



@end
