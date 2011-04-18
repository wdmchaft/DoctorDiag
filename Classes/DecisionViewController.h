//
//  DecisionViewController.h
//  DoctorDiag
//
//  Created by InICe on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DecisionViewController : UIViewController {
	NSMutableArray *pathArray;
	NSArray *datasource;
	NSDictionary *currentNode;	
	NSString *listFile;
	
  IBOutlet UIButton *yesLink, *noLink;
	//IBOutlet UILabel *quoteLabel;
	IBOutlet UILabel *parentNodeLabel;
	IBOutlet UITextView *quoteField;
}

@property (nonatomic, retain) IBOutlet UILabel *parentNodeLabel;
@property (nonatomic, retain) NSDictionary *currentNode;
@property (nonatomic, retain) NSArray *datasource;
@property (nonatomic, retain) NSMutableArray *pathArray;
@property (nonatomic, copy) NSString *listFile;

- (NSString *)_getYesNodeTitleFromNode:(NSDictionary *)node;
- (NSString *)_getNoNodeTitleFromNode:(NSDictionary *)node;

- (void)setDataFromSource;

- (void)_traverseToNodeName:(NSString *)nodeTitle;
- (BOOL)_toYesNode;
- (BOOL)_toNoNode;

- (IBAction)yesAction:(id)sender;
- (IBAction)noAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)showAllState:(id)sender;


- (void)refreshView;




@end
