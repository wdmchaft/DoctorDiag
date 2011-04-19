//
//  ShowDiagNodeTree.m
//  DoctorDiag
//
//  Created by InICe on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShowDiagNodeTree.h"
#import "DiagNode.h"

@implementation ShowDiagNodeTree

@synthesize datasource;

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
    [super viewDidLoad];
	int i=0;
	//CGFloat lineSpacing    = 10.0f;
	CGFloat buttonSpacing  = 20.0f;
	CGFloat buttonWidth    = 120.0f;
	CGFloat buttonHeight   = 40.0f;
	
	for (UIButton *node in self.datasource) {
		UIButton *decisionNode = [[UIButton alloc] init];
		decisionNode.titleLabel.textColor = [UIColor blackColor];
		[decisionNode setTitle:[node valueForKey:@"text"] forState:UIControlStateNormal];
		decisionNode.frame = CGRectMake(60, 40 + (++i * 60) + buttonSpacing, buttonWidth, buttonHeight);
		decisionNode.backgroundColor = [UIColor colorWithRed:0.235 green:0.639 blue:0.0 alpha:1.0];
		[self.view addSubview:decisionNode];
		
		//CGPoint *path = CGPointMake(60, 20);
		
		[decisionNode release];
	}
	// Implement Each node
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (IBAction)backAction {
	[self.navigationController popViewControllerAnimated:YES];
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
    [super dealloc];
}


@end
