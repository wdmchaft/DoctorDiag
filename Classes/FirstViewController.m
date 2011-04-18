//
//  FirstViewController.m
//  DoctorDiag
//
//  Created by InICe on 4/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstModalViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation FirstViewController

@synthesize startDiag;
@synthesize modalView;

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
  
  [super viewDidLoad];
	
}
// Create a ModalView to select first yourselves diagnosis
- (IBAction)start:(id)sender {
	
	self.modalView = [[FirstModalViewController alloc] initWithNibName:@"FirstModalViewController" bundle:[NSBundle bundleWithIdentifier:@"xib"]];
	
	// By hand adding items to TableController
	self.modalView.listItem = [NSArray arrayWithObjects:@"ปวดหลัง", @"ไข้", @"ปวดหัว", nil];
	
	/*
	 
	//Tried to use CoreaAnimation for transition a view

	UIView *currentView = self.view;
	UIView *window = [currentView superview];
	[window addSubview:self.modalView.view];
	[currentView removeFromSuperview];
	
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.6];
	[animation setType:kCATransitionMoveIn];
	[animation setSubtype:kCATransitionFromTop];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	
	[[window layer] addAnimation:animation forKey:@"Switch Modal View"];
	*/
	
	// Push ViewController to main Navigation Controller
	[self.navigationController pushViewController:modalView animated:YES];

}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
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
	[self.modalView release];
	[self.startDiag release];
    [super dealloc];
}


@end
