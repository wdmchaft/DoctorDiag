//
//  DecisionViewController.m
//  DoctorDiag
//
//  Created by InICe on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DecisionViewController.h"

@implementation DecisionViewController

@synthesize datasource;
@synthesize currentNode;
@synthesize pathArray;
@synthesize parentNodeLabel;
@synthesize listFile;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.navigationController.navigationBarHidden = YES;

  [self getDataFromSource];
	
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
	return YES;
}

- (void)getDataFromSource {
	
	NSBundle *bundle = [NSBundle mainBundle];

	NSString *plistPath = [bundle pathForResource:self.listFile ofType:@"plist"];
  
	self.datasource = [[NSArray alloc] initWithContentsOfFile:plistPath];	
	
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
				
				self.currentNode = [self.datasource objectAtIndex:[self.datasource indexOfObject:object]];
				
				[self.pathArray addObject:[self.currentNode copy]];
			} 
			else if ([[object valueForKey:@"type"] isEqualToString:@"End"]) {

				quoteField.backgroundColor = [UIColor greenColor];
				
				self.currentNode = [self.datasource objectAtIndex:[self.datasource indexOfObject:object]];
			}
			else {
				NSLog(@"Node type did not match.");
			}
		}}];
}

- (void)refreshView {
	quoteField.text = [self.currentNode valueForKey:@"text"];
	
	[self.pathArray enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
		
		NSLog(@"%@ ,",[object valueForKey:@"node"]);
		
	}];
}

- (BOOL)_toYesNode {
	[self _traverseToNodeName:[self _getYesNodeTitleFromNode:self.currentNode]];
	NSLog(@"Current Node : %@",[self.currentNode valueForKey:@"text"]);
	return YES;
}

- (BOOL)_toNoNode {
	[self _traverseToNodeName:[self _getNoNodeTitleFromNode:self.currentNode]];
	NSLog(@"Current Node : %@",[self.currentNode valueForKey:@"text"]);
	
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
	[quoteField release];
	[self.parentNodeLabel release];
	[self.pathArray release];
	[self.currentNode release];
  [self.datasource release];
  [super dealloc];
}


@end
