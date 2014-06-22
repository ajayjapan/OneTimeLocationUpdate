//
//  GetLocation.h
//  around
//
//  Created by Ajay Chainani on 4/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//You must import the CoreLocation Framework
#import <CoreLocation/CoreLocation.h>

//You are conforming to the CoreLocation Manager protocol
@interface GetLocation : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL gotLocation;
@property (nonatomic, assign) NSTimeInterval waitTime;

+ (GetLocation *)sharedInstance;

//Accessible Functions
- (void)getCurrentLocation;

@end

extern NSString * const ACGetLocationSuccessNotification;
extern NSString * const ACGetLocationFailureNotification;
