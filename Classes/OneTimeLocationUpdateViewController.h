//
//  OneTimeLocationUpdateViewController.h
//  OneTimeLocationUpdate
//
//  Created by Ajay Chainani on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetLocation.h"

@interface OneTimeLocationUpdateViewController : UIViewController <LocationDataDelegate> {
	
	GetLocation *getLoc;
	UIButton *refreshButton;
}

@end

