//
//  ShowDiagNodeTree.h
//  DoctorDiag
//
//  Created by InICe on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShowDiagNodeTree : UIViewController {
	CGFloat buttonSpacing;
	CGFloat buttonWidth;
	CGFloat buttonHeight; 
	NSMutableArray *datasource, *nodeButtonArray;
	IBOutlet UIButton *backButton;
	IBOutlet UIScrollView *scrollView;
	NSTimer *timer;
	int countButton;
}

@property(nonatomic, retain) NSMutableArray *datasource;
- (IBAction)backAction;
- (void)timeTicker;
- (void)createNode;
@end
