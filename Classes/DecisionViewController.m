//
//  DecisionViewController.m
//  DoctorDiag
//
//  Created by InICe on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DecisionViewController.h"
#import "ShowDiagNodeTree.h"

@implementation DecisionViewController

@synthesize datasource;
@synthesize currentNode;
@synthesize previousNode;
@synthesize pathArray;
@synthesize parentNodeLabel;
@synthesize listFile;
@synthesize quoteField;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
				// self.quoteField
        // Custom initialization.
    }
    return self;
}

// Set datasource (Now is Plist source) to Decision Tree
- (void)setDataFromSource {
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:self.listFile ofType:@"plist"];
	self.datasource = [[NSArray alloc] initWithContentsOfFile:plistPath];	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.navigationController.navigationBarHidden = YES;
  [self setDataFromSource];
	self.currentNode = [[NSDictionary alloc] initWithDictionary:[self.datasource objectAtIndex:1]];
	self.pathArray = [[NSMutableArray alloc] init];
	
	[yesLink addTarget:self action:@selector(yesAction:) forControlEvents:UIControlEventTouchDown];
	[noLink addTarget:self action:@selector(noAction:) forControlEvents:UIControlEventTouchDown];
	
	[self refreshView];
	[super viewDidLoad];
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return NO;
}

- (NSString *)_getNodeId:(NSDictionary *)node {
	return [node valueForKey:@"node"];
}

- (NSString *)_getYesNodeTitleFromNode:(NSDictionary *)node {
	return [node valueForKey:@"yes"];
}

- (NSString *)_getNoNodeTitleFromNode:(NSDictionary *)node {
	return [node valueForKey:@"no"];
}

- (NSString *)pickUpPlist:(NSIndexPath *)indexPath {
 	
	NSArray *arrayOfPlist = [NSArray arrayWithObjects:@"disease-backache", @"disease-flu", nil];
	
	return [arrayOfPlist objectAtIndex:indexPath.row];
	
}

- (void)_traverseToNodeName:(NSString *)nodeTitle {
	[self.datasource enumerateObjectsUsingBlock:^(id object,NSUInteger index,BOOL *stop) {
		
		if ([nodeTitle isEqualToString:[object valueForKey:@"node"]]) {
			if ([[object valueForKey:@"type"] isEqualToString:@"Decision"]) {
				self.previousNode = self.currentNode;
				self.currentNode = [self.datasource objectAtIndex:[self.datasource indexOfObject:object]];
				[self.pathArray addObject:[self.currentNode copy]];
			} 
			else if ([[object valueForKey:@"type"] isEqualToString:@"End"]) {
				self.quoteField.backgroundColor = [UIColor greenColor];
				self.currentNode = [self.datasource objectAtIndex:[self.datasource indexOfObject:object]];
			}
			else {
				NSLog(@"Node type did not match.");
			}
		}}];
}

- (void)refreshView {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.7];
  [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.quoteField cache:NO];
	[UIView commitAnimations];
	
	self.quoteField.text = [self.currentNode valueForKey:@"text"];
	/*
	[self.pathArray enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
		NSLog(@"%@ ,",[object valueForKey:@"node"]);
	}];
	*/
}

- (BOOL)_toYesNode {
	[self _traverseToNodeName:[self _getYesNodeTitleFromNode:self.currentNode]];
	
	return YES;
}

- (BOOL)_toNoNode {
	[self _traverseToNodeName:[self _getNoNodeTitleFromNode:self.currentNode]];
	
	return YES;
}

- (IBAction)yesAction:(id)sender {
	// Get Next Node
	[self _toYesNode];
	[self refreshView];
}

- (IBAction)noAction:(id)sender {
  // Get Next Node
	[self _toNoNode];
	[self refreshView];
}

- (IBAction)backAction:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showAllState:(id)sender {
	NSLog(@"Show all decision state");
	ShowDiagNodeTree *showAllTree = [[ShowDiagNodeTree alloc] initWithNibName:@"ShowDiagNodeTree" bundle:[NSBundle bundleWithIdentifier:@"xib"]];
	showAllTree.datasource = self.pathArray;
	[self.navigationController pushViewController:showAllTree animated:YES];
	
	[showAllTree release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.quoteField release];
	[self.parentNodeLabel release];
	[self.pathArray release];
	[self.currentNode release];
  [self.datasource release];
  [super dealloc];
}


@end
