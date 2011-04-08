//
//  FirstModalViewController.h
//  DoctorDiag
//
//  Created by InICe on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstModalViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	NSMutableArray *listItem;
	
	IBOutlet UIView *view;
	IBOutlet UITableView *tablewView;
	IBOutlet UIButton *backButton, *diagStart;

}

@property(nonatomic, retain) NSMutableArray *listItem;

- (IBAction)back:(id)sender;

@end
