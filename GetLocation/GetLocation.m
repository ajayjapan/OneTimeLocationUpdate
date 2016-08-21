//
//  GetLocation.m
//  around
//
//  Created by Ajay Chainani on 4/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetLocation.h"

#define MAX_TIME_FOR_BEST_LOCATION 5 //SECONDS
#define DESIRED_ACCURACY 100 //METERS

NSString * const ACGetLocationSuccessNotification = @"com.ajay.get.location.success";
NSString * const ACGetLocationFailureNotification = @"com.ajay.get.location.failure";
NSString * const ACGetLocationErrorDomain = @"ACGetLocationErrorDomain";

@implementation GetLocation

@synthesize locationManager, timer, gotLocation, waitTime;

+ (GetLocation *)sharedInstance {
  static GetLocation *_sharedInstance = nil;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    _sharedInstance = [[self alloc] init];
  });
  
  return _sharedInstance;
}

- (id)init{
  if (self = [super init]){
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy= kCLLocationAccuracyBest;
    self.waitTime = MAX_TIME_FOR_BEST_LOCATION;
  }
  return self;
}


-(void)pushBest {
  CLLocation *location = self.locationManager.location;
  
  if (!location) {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedStringFromTable(@"Couldn't get a location within the time limit", @"ACGetLocation", nil) forKey:NSLocalizedFailureReasonErrorKey];
    NSError *error = [[NSError alloc] initWithDomain:ACGetLocationErrorDomain
                                                code:kCLErrorLocationUnknown
                                            userInfo:userInfo];
    [self locationManager:self.locationManager didFailWithError:error];
    return;
  }
  
  if(!gotLocation) {
    
    gotLocation = YES;
    
    NSLog(@"stopUpdatingLocation");
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"gotLocation");
    [[NSNotificationCenter defaultCenter] postNotificationName:ACGetLocationSuccessNotification
                                                        object:location];
    
    NSLog(@"invalidate timer");
    [timer invalidate];
    self.timer = nil;
  }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
  
  if(!gotLocation) {
    NSLog(@"%f", newLocation.horizontalAccuracy);
    if (newLocation.horizontalAccuracy <  DESIRED_ACCURACY && newLocation.horizontalAccuracy != -1) {
      if ((newLocation.coordinate.longitude !=  0)&&(newLocation.coordinate.latitude !=  0)) {
        if ((newLocation.coordinate.longitude !=  oldLocation.coordinate.longitude)&&(newLocation.coordinate.latitude !=  oldLocation.coordinate.latitude)) {
          gotLocation = YES;
          
          NSLog(@"gotLocation");
          [[NSNotificationCenter defaultCenter] postNotificationName:ACGetLocationSuccessNotification
                                                              object:newLocation];
          
          NSLog(@"invalidate timer");
          [timer invalidate];
          self.timer = nil;
          
          NSLog(@"stopUpdatingLocation");
          [self.locationManager stopUpdatingLocation];
        }
      }
    }
  }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  [[NSNotificationCenter defaultCenter] postNotificationName:ACGetLocationFailureNotification
                                                      object:error];
}


- (void)startTimer {
  self.timer = [NSTimer scheduledTimerWithTimeInterval:self.waitTime
                                                target:self
                                              selector:@selector(pushBest)
                                              userInfo:nil
                                               repeats:NO];
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  if (status == kCLAuthorizationStatusNotDetermined) {
    return;
  }
  [self getCurrentLocation];
}


- (void)getCurrentLocation {
  CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
  if (authorizationStatus == kCLAuthorizationStatusDenied) {
    return;
  } else if (authorizationStatus == kCLAuthorizationStatusNotDetermined){
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
      [self.locationManager requestWhenInUseAuthorization];
      return;
    }
  }

  [self.locationManager startUpdatingLocation];
  
  [self startTimer];
  
  gotLocation = NO;
  
  NSLog(@"searching for location..");
}

- (void)dealloc {
  self.locationManager.delegate = nil;
}

@end
