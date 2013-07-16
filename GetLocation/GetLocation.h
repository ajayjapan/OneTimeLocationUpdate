//
//  GetLocation.h
//  around
//
//  Created by Ajay Chainani on 4/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//You must import the CoreLocation Framework
#import <CoreLocation/CoreLocation.h>

@protocol LocationDataDelegate
@required
//2 things can happen it can return the location or return an error (we handle the error within this class)
- (void)gotLocation:(CLLocation *)location;
- (void)gotError:(NSError *)error;
@end

//You are conforming to the CoreLocation Manager protocol
@interface GetLocation : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL gotLocation;
@property (nonatomic, assign) NSTimeInterval waitTime;

//Accessible Functions
- (void)getCurrentLocation;


@end

extern NSString * const ACGetLocationSuccessNotification;
extern NSString * const ACGetLocationFailureNotification;
