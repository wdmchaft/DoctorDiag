//
//  FirstViewController.h
//  DoctorDiag
//
//  Created by InICe on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModalViewController.h"

@interface FirstViewController : UIViewController {
	
	IBOutlet UIButton *startDiag;
	
	FirstModalViewController *modalView;
}

@property (nonatomic, retain) IBOutlet UIButton *startDiag;
@property (nonatomic, retain) FirstModalViewController *modalView;

- (IBAction)start:(id)sender;

@end
