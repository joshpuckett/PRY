PRY
===

PRY is an app that sends device info to Quartz Composer. It communicates using PeerTalk to a custom patch called QCDeviceInfo. You'll need to download the Xcode project and build PRY to your phone to use it (requires Apple Developer Account). Launch PRY on your phone, then launch QC to get started.

PRY and QCDeviceInfo allow you to easily and rapidly design interactions that take advantage of the iPhone's device info like rotation or accelerometer data, such as Facebook Paper's tilt-to-view-photo interaction: 

Video here: https://www.dropbox.com/s/ybalgw6b863gl2c/qcdeviceinfo.mov

Tilt-to-view example composition: https://www.dropbox.com/s/pln6yj54ab6ksep/tilttoview.qtz

![Tilt-to-view-photo](https://photos-5.dropbox.com/t/0/AABeJbnraWlDHdtPiLLqoWtvKyWHlTcCA2szF3bgSZqyig/12/144234624/png/2048x1536/3/1397012400/0/2/Screenshot%202014-04-08%2018.28.55.png/yVQ4wqSGJ4S3qBkM21D9n--_X0vBFa15UafgPXPZi8A)

Grab QCDeviceInfoPatch here: https://www.dropbox.com/s/ld2vyyv3w7u5coi/QCDeviceInfo.plugin.zip

![QCDeviceInfo Patch](https://photos-2.dropbox.com/t/0/AABK6kU0Pd0RyLwS0EghETVTNlmJnPnSA2541ahnOrGD-Q/12/144234624/png/2048x1536/3/1397012400/0/2/Screenshot%202014-04-08%2018.22.03.png/bScr20CWzQnwXbz6BHD7EEbZTC1SGyvV5wZInjnGIHw)

* Pitch: returns pitch (x-axis) in degrees
* Roll: returns roll (y-axis) in degrees
* Yaw: returns yaw (z-axis) in degrees
* Acceleration X: returns x-axis acceleration in G's.
* Acceleration Y: returns y-axis acceleration in G's.
* Acceleration Z: returns z-axis acceleration in G's.
* Orientation: returns 0 for portrait, 1 for landscape.
