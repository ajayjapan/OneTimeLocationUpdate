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

@implementation GetLocation

@synthesize locationManager, delegate, timer, gotLocation;

- (id)init{ 
  if (self = [super init]){
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy= kCLLocationAccuracyBest;
  }
  return self;
}


-(void)pushBest
{
  if (self.locationManager.location) {
    if(!gotLocation) {
      
      gotLocation = YES;
      
      NSLog(@"stopUpdatingLocation");
      [self.locationManager stopUpdatingLocation];
      
      NSLog(@"gotLocation");
      [self.delegate gotLocation:self.locationManager.location];
      
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
			if ((self.locationManager.location.coordinate.longitude !=  0)&&(self.locationManager.location.coordinate.latitude !=  0)) {
				
				gotLocation = YES;
				
				NSLog(@"gotLocation");
				[self.delegate gotLocation:newLocation];
				
        NSLog(@"invalidate timer");
        [timer invalidate];
        self.timer = nil;
				
				NSLog(@"stopUpdatingLocation");
				[self.locationManager stopUpdatingLocation];
			}
		}
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"There was an error in determining you location. We need your location to proceed. Try refreshing." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
  
  [self.delegate gotLocation:nil];
  
}


- (void)startTimer {
  
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:MAX_TIME_FOR_BEST_LOCATION 
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
  
    self.timer = nil;
    self.locationManager.delegate = nil;
    self.locationManager = nil;

    [super dealloc];
}

@end
