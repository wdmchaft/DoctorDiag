//
//  DoctorDiagAppDelegate.h
//  DoctorDiag
//
//  Created by InICe on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"

@interface DoctorDiagAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
	UINavigationController *navigationController;
	FirstViewController *firstView;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) FirstViewController *firstView;

@end

