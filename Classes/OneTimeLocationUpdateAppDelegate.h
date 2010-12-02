//
//  OneTimeLocationUpdateAppDelegate.h
//  OneTimeLocationUpdate
//
//  Created by Ajay Chainani on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OneTimeLocationUpdateViewController;

@interface OneTimeLocationUpdateAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    OneTimeLocationUpdateViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet OneTimeLocationUpdateViewController *viewController;

@end

