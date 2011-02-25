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


-(void)pushBest
{
	if(!gotLocation) {

		NSLog(@"stopUpdatingLocation");
		[locationManager stopUpdatingLocation];
				
		NSLog(@"gotLocation");
		[self.delegate gotLocation:locationManager.location];
				
		NSLog(@"invalidate timer");
		[timer invalidate];
		timer = nil;
	}
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	
	if(!gotLocation) {
		NSLog(@"%f", newLocation.horizontalAccuracy);
		if (newLocation.horizontalAccuracy <  DESIRED_ACCURACY) {
			if ((locationManager.location.coordinate.longitude !=  0)&&(locationManager.location.coordinate.latitude !=  0)) {
				
				gotLocation = YES;
				
				NSLog(@"gotLocation");
				[self.delegate gotLocation:newLocation];
				
				NSLog(@"invalidate timer");
				[timer invalidate];
				timer = nil;
				
				NSLog(@"stopUpdatingLocation");
				[locationManager stopUpdatingLocation];
			}
		}
	}
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error {
	NSLog(@"The ERROR WAS: %i",[error code]);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"We Couldn't get your Current Location. Try Again A Bit Later." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
	
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

	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy= kCLLocationAccuracyBest;
			
	[locationManager startUpdatingLocation];
	
	[self startTimer];
	
	gotLocation = NO;
	
	NSLog(@"searching for location..");

}

- (void)dealloc {
  [super dealloc];
	
  locationManager.delegate = nil;
	[locationManager release];
	locationManager = nil;
}

@end
