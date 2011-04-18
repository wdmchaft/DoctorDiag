//
//  ShowDiagNodeTree.h
//  DoctorDiag
//
//  Created by InICe on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShowDiagNodeTree : UIViewController {

	NSMutableArray *datasource;
	IBOutlet UIButton *backButton;
	
}

@property(nonatomic, retain) NSMutableArray *datasource;
- (IBAction)backAction;
@end
