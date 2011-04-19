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
	NSDictionary *currentNode, *previousNode;
	NSString *listFile, *titleLabel;
	
  IBOutlet UIButton *yesLink, *noLink, *viewAllLink, *backwardLink;
	IBOutlet UILabel *parentNodeLabel;
	IBOutlet UITextView *quoteField;
}

@property (nonatomic, retain) IBOutlet UILabel *parentNodeLabel;
@property (nonatomic, retain) IBOutlet UITextView *quoteField;
@property (nonatomic, retain) NSDictionary *currentNode;
@property (nonatomic, retain) NSDictionary *previousNode;
@property (nonatomic, retain) NSArray *datasource;
@property (nonatomic, retain) NSMutableArray *pathArray;
@property (nonatomic, copy) NSString *listFile;

- (NSString *)getYesNodeTitleFromNode:(NSDictionary *)node;
- (NSString *)getNoNodeTitleFromNode:(NSDictionary *)node;

- (void)setDataFromSource;

- (void)traverseToNodeName:(NSString *)nodeTitle;

- (IBAction)traverseBackward:(id)sender;
- (IBAction)yesAction:(id)sender;
- (IBAction)noAction:(id)sender;

- (IBAction)backAction:(id)sender;
- (IBAction)showAllState:(id)sender;


- (void)refreshView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withRootNodeLabel:(NSString *)titleLabel;



@end
