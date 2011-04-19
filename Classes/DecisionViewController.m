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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withRootNodeLabel:(NSString *)rootNodeLabel {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
			titleLabel = [[NSString alloc] init];
			titleLabel = [rootNodeLabel copy];
    }
    return self;
}

// Set datasource (Now is Plist source) to Decision Tree
- (void)setDataFromSource {
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:self.listFile ofType:@"plist"];
	self.datasource = [[NSArray alloc] initWithContentsOfFile:plistPath];	
}

- (void)viewWillAppear:(BOOL)animated {
	self.parentNodeLabel.text = titleLabel;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.navigationController.navigationBarHidden = YES;
	
	// Retrieve data set from plist.
  [self setDataFromSource];
	
	// Initialize Object for handle current node.
	self.currentNode = [[NSDictionary alloc] initWithDictionary:[self.datasource objectAtIndex:1]];
	
	// Initialize Storable Array for node tracking.
	self.pathArray = [[NSMutableArray alloc] init];
	
	// Insert root node to path array
	[self.pathArray addObject:self.currentNode];
	
	// Display Node
	[self refreshView];
	[super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

// Method for retrive node id from Dictionary
- (NSString *)getNodeIdFromObject:(NSDictionary *)node {
	return [node valueForKey:@"node"];
}

- (NSString *)getYesNodeTitleFromNode:(NSDictionary *)node {
	return [node valueForKey:@"yes"];
}

- (NSString *)getNoNodeTitleFromNode:(NSDictionary *)node {
	return [node valueForKey:@"no"];
}

// Insert file name of plist to array.
- (NSString *)pickUpPlist:(NSIndexPath *)indexPath {
	NSArray *arrayOfPlist = [NSArray arrayWithObjects:@"disease-backache", @"disease-flu", nil];
	return [arrayOfPlist objectAtIndex:indexPath.row];
}

// Implement Tree Traversal.
// Using Block 
// Require iOS 4.0 or later
- (void)traverseToNodeName:(NSString *)nodeTitle {
	
	NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
	[self.datasource enumerateObjectsUsingBlock:^(id object,NSUInteger index,BOOL *stop) {
		
		// Check whether node name is similar to travarsed node
		if ([nodeTitle isEqualToString:[object valueForKey:@"node"]]) {
			
			// Check whether node type is Decision Node
			if ([[object valueForKey:@"type"] isEqualToString:@"Decision"]) {
				self.previousNode = self.currentNode;
				self.currentNode = [self.datasource objectAtIndex:[self.datasource indexOfObject:object]];
				[self.pathArray addObject:[self.currentNode copy]];
			}
			// End node 
			else if ([[object valueForKey:@"type"] isEqualToString:@"End"]) {
				
				self.quoteField.backgroundColor = [UIColor greenColor];
				self.currentNode = [self.datasource objectAtIndex:[self.datasource indexOfObject:object]];
				[self.pathArray addObject:self.currentNode];
				
			}
			else {
				NSLog(@"Node Type is not match. :: %@",[object valueForKey:@"type"]);
			}
		}}
	 ];
	
	NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate] - startTime;
	NSLog(@"Duration : %f ms",time * 10*10*10);
	
}

- (void)refreshView {
	
	// Node Transition, using Page Curl Up
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.7];
  [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.quoteField cache:NO];
	[UIView commitAnimations];
	
	// Get CurrentText from traversed node 
	self.quoteField.text = [self.currentNode valueForKey:@"text"];
	
	if ([self.pathArray count] > 1) {
		backwardLink.titleLabel.textColor = [UIColor darkGrayColor];
		viewAllLink.titleLabel.textColor = [UIColor darkGrayColor];
	}
	else {
		backwardLink.titleLabel.textColor = [UIColor lightGrayColor];
		viewAllLink.titleLabel.textColor = [UIColor lightGrayColor];
	}

	if ([[self.currentNode valueForKey:@"type"] isEqualToString:@"End"]) {
		self.quoteField.backgroundColor = [UIColor greenColor];
	}
	else {
		self.quoteField.backgroundColor = [UIColor whiteColor];
	}

	/*
	// Monitor pathArray Object
	[self.pathArray enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
		NSLog(@"%@ ,",[object valueForKey:@"node"]);
	}];
	*/
}

- (IBAction)yesAction:(id)sender {
	// Move to yesNode
	[self traverseToNodeName:[self getYesNodeTitleFromNode:self.currentNode]];
	[self refreshView];
}

- (IBAction)noAction:(id)sender {
  // Move to noNode
	[self traverseToNodeName:[self getNoNodeTitleFromNode:self.currentNode]];
	[self refreshView];
}

// Move back from currentNode
- (IBAction)traverseBackward:(id)sender; {
	@try {
		if ([self.pathArray count] > 1) {
			[self.pathArray removeLastObject];
			self.currentNode = [self.pathArray lastObject];
			[self refreshView];
		}
	}
	@catch (NSException * e) {
		NSLog(@"Minimum PathArray.");
	}
}

- (IBAction)backAction:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showAllState:(id)sender {
	ShowDiagNodeTree *showAllTree = [[ShowDiagNodeTree alloc] 
																	 initWithNibName:@"ShowDiagNodeTree" bundle:[NSBundle bundleWithIdentifier:@"xib"]];
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
	[titleLabel release];
	[self.quoteField release];
	[self.parentNodeLabel release];
	[self.pathArray release];
	[self.currentNode release];
  [self.datasource release];
  [super dealloc];
}


@end
