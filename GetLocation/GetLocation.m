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

@implementation GetLocation

@synthesize locationManager, timer, gotLocation, waitTime;

- (id)init{ 
  if (self = [super init]){
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy= kCLLocationAccuracyBest;
    self.waitTime = MAX_TIME_FOR_BEST_LOCATION;
  }
  return self;
}


-(void)pushBest
{
    CLLocation *location = self.locationManager.location;
    if (location) {
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
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	
	if(!gotLocation) {
		NSLog(@"%f", newLocation.horizontalAccuracy);
		if (newLocation.horizontalAccuracy <  DESIRED_ACCURACY) {
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

//    UIAlertView *alert = nil;
//    
//    if (error.code ==  kCLErrorDenied) {
//        
//        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
//        
//        NSString *errorMessage = [NSString stringWithFormat:@"We need access your location. Please go to Settings > Location Services and turn location services on for %@. Thanks.", appName];
//        
//        alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        
//    } else {
//        alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"There was an error in determining you location. We need your location to proceed. Try refreshing." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    }
//    
//    [alert show];
//    

}


- (void)startTimer {
  
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:self.waitTime
                                                target:self 
                                              selector:@selector(pushBest) 
                                              userInfo:nil 
                                               repeats:NO];
	
}


- (void)getCurrentLocation
{
  
	[self.locationManager startUpdatingLocation];
	
	[self startTimer];
	
	gotLocation = NO;
	
	NSLog(@"searching for location..");
  
}

- (void)dealloc {
  
    self.locationManager.delegate = nil;
    self.locationManager = nil;
    self.timer = nil;

}

@end
