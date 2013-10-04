//
//  OneTimeLocationUpdateViewController.m
//  OneTimeLocationUpdate
//
//  Created by Ajay Chainani on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OneTimeLocationUpdateViewController.h"

@implementation OneTimeLocationUpdateViewController

@synthesize getLoc = _getLoc;
@synthesize refreshButton = _refreshButton;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Initialize Location Class
	_getLoc = [[GetLocation alloc] init];
	
    //Add notification observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotLocationNotification:) name:ACGetLocationSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotErrorNotification:) name:ACGetLocationFailureNotification object:nil];

	//Way to getCurrentLocation simply
	//[getLoc getCurrentLocation];
	
	//Way to getCurrentLocation via button
	_refreshButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	_refreshButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
	_refreshButton.center = self.view.center;
	[_refreshButton setTitle:@"Refresh" forState:UIControlStateNormal ];
	[_refreshButton addTarget:_getLoc action:@selector(getCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    
	[self.view addSubview:_refreshButton];
	
}

//Observer Methods

- (void)gotErrorNotification:(NSNotification *)notification {
    
    [self gotError:notification.object];
}

- (void)gotLocationNotification:(NSNotification *)notification {
    
    [self gotLocation:notification.object];
}

- (void)gotLocation:(CLLocation *)location {
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Got Location"
                                                    message:location.description
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

- (void)gotError:(NSError *)error {
    
    UIAlertView *alert = nil;
    
    if (error.code ==  kCLErrorDenied) //When the user denies the application access to your location
    {
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        
        NSString *errorMessage = [NSString stringWithFormat:@"We need access your location. Please go to Settings > Location Services and turn location services on for %@. Thanks.", appName];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
    } else {
        
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error in determining you location. We need your location to proceed. Try refreshing." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    }
    
    [alert show];
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
