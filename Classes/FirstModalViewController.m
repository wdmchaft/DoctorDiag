//
//  FirstModalViewController.m
//  DoctorDiag
//
//  Created by InICe on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstModalViewController.h"
#import "DecisionViewController.h"
#import "FirstViewController.h"
#import "HowToDiagModalViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation FirstModalViewController

@synthesize listItem;

#pragma mark -
#pragma mark View lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization.
	}
	return self;
}

- (IBAction)back:(id)sender {
	// Prepair for using viewController without NavigationController
	[self.navigationController popViewControllerAnimated:YES];
	
	/*
	UIView *currentView = [self view];

	FirstViewController *firstView = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:[NSBundle bundleWithIdentifier:@"xib"]];

	[currentView.superview addSubview:firstView.view];
	
	[self.view removeFromSuperview];
	*/
	
}

- (IBAction)info:(id)sender {
	HowToDiagModalViewController *showModal = [[HowToDiagModalViewController alloc] initWithNibName:@"HowToDiagModalViewController" bundle:[NSBundle bundleWithIdentifier:@"xib"]];
	[showModal setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];

	[self.navigationController presentModalViewController:showModal animated:YES];
	
	[showModal release];
	
}

- (void)viewDidLoad {
	self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)\DidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
		//return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [self.listItem count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
    // Configure the cell...
    cell.textLabel.text = [self.listItem objectAtIndex:indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


// By hand adding source file (Plist) to array and also return file name
- (NSString *)listFileNameFromIndex:(NSIndexPath *)indexPath {
	NSArray *arrayOfFile = [NSArray arrayWithObjects:@"disease-backache", @"disease-flu", @"disease-headache", nil];
	
	return [arrayOfFile objectAtIndex:indexPath.row];
}


#pragma mark -
#pragma mark Table view delegate

// Determine when user select on that row of TableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	DecisionViewController *decisionView = [[DecisionViewController alloc] 
																					initWithNibName:@"DecisionViewController" bundle:[NSBundle bundleWithIdentifier:@"xib"] 
																					withRootNodeLabel:
																					[NSString stringWithFormat:@"อาการ%@",[self.listItem objectAtIndex:indexPath.row]]];
	
	decisionView.listFile = [[self listFileNameFromIndex:indexPath] copy];
	
	NSLog(@"Text Label : %@", [NSString stringWithFormat:@"อาการ%@",[self.listItem objectAtIndex:indexPath.row]]);
	//decisionView.parentNodeLabel.text = [NSString stringWithFormat:@"อาการ%@",[self.listItem objectAtIndex:indexPath.row]];
	
	[self.navigationController pushViewController:decisionView animated:YES];
	//[self.parentViewController dismissModalViewControllerAnimated:YES];
	//decisionView.parentNodeLabel.text = [NSString stringWithFormat:@"อาการ%@",[self.listItem objectAtIndex:indexPath.row]]
	
	[decisionView release];
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[self.listItem release];
  [super dealloc];
}


@end

