# OneTimeLocationUpdate

It is very time consuming to integrate CoreLocation into your iOS project.

This objective-C convinence library makes it easy to get the best location.

### Documentation

The location is sent it to controller via `NSNotificationCenter`.

There are two kinds of expected notifications: 

`ACGetLocationSuccessNotification` or `ACGetLocationFailureNotification`

Please look at `Classes/OneTimeLocationUpdateViewController.m` on how to intergate it into your application.

### Installation

The library code can be found in the `GetLocation` folder or simply add the following to your podspec

```
pod 'GetLocation', :git => 'https://github.com/achainan/OneTimeLocationUpdate.git'
```

