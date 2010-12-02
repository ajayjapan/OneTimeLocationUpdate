//
//  OneTimeLocationUpdateViewController.m
//  OneTimeLocationUpdate
//
//  Created by Ajay Chainani on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OneTimeLocationUpdateViewController.h"

@implementation OneTimeLocationUpdateViewController



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
	getLoc = [[GetLocation alloc] init];
	getLoc.delegate = self;
	
	//Way to getCurrentLocation simply
	//[getLoc getCurrentLocation];
	
	//Way to getCurrentLocation via button
	refreshButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	refreshButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
	refreshButton.center = self.view.center;
	[refreshButton setTitle:@"Refresh" forState:UIControlStateNormal ];
	[refreshButton addTarget:getLoc action:@selector(getCurrentLocation) forControlEvents:UIControlEventTouchUpInside];  
    
	[self.view addSubview: refreshButton];
	
}

//Initialize Required Methods

- (void)gotLocation:(CLLocation *)location {
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Got Location" message:location.description delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
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
    [super dealloc];
	
	[refreshButton release];
	
	getLoc.delegate = nil;
	[getLoc release];
	getLoc = nil;
}

@end
