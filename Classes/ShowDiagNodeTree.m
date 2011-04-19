//
//  ShowDiagNodeTree.m
//  DoctorDiag
//
//  Created by InICe on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/CoreAnimation.h>
#import "ShowDiagNodeTree.h"

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
	
	//lineSpacing    = 10.0f;
	buttonSpacing  = 20.0f;
	buttonWidth    = 200.0f;
	buttonHeight   = 40.0f;
	
	nodeButtonArray = [[NSMutableArray alloc] init];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(timeTicker) userInfo:nil repeats:YES];
	
	[scrollView setContentSize:CGSizeMake(280, [self.datasource count] * 60)];
	[scrollView setContentOffset:CGPointMake(0, 0)];
	
	[self createNode];
}

- (void)timeTicker {
	if (countButton < [nodeButtonArray count]) {
		UIButton *aButton = [nodeButtonArray objectAtIndex:countButton];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.55];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:aButton cache:NO];
		aButton.frame = CGRectMake(40, 0 + (countButton * 60) + buttonSpacing, buttonWidth, buttonHeight);
		countButton++;
		[UIView commitAnimations];
		
		// Bouncing Animation Tutorial from http://www.uchidacoonga.com/2010/12/how-to-slide-in-new-window-with-bounce-animation/
		CABasicAnimation *bounceAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
		bounceAnimation.duration = 0.2;
		bounceAnimation.fromValue = [NSNumber numberWithInt:0];
		bounceAnimation.toValue = [NSNumber numberWithInt:10];
		bounceAnimation.repeatCount = 2;
		bounceAnimation.autoreverses = YES;
		bounceAnimation.fillMode = kCAFillModeForwards;
		bounceAnimation.removedOnCompletion = NO;
		bounceAnimation.additive = YES;
		[aButton.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
		
	}
}


- (void)createNode {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int i=0;
	for (UIButton *node in self.datasource) {
		
		UIButton *decisionNode = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		decisionNode.titleLabel.textColor = [UIColor blackColor];
		decisionNode.titleLabel.lineBreakMode = 2;
		
		[decisionNode setTitle:[node valueForKey:@"text"] forState:UIControlStateNormal];
		decisionNode.frame = CGRectMake(500, 0 + (i * 60) + buttonSpacing, buttonWidth, buttonHeight);
		
		[nodeButtonArray addObject:decisionNode];
		
		[scrollView addSubview:decisionNode];
		//[self animationWithNode:decisionNode sequenceNo:i];
		
		i++;
	}
	countButton = 0;
	[pool drain];
	
	NSLog(@"NodeButtonArray : %@", nodeButtonArray);
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
	[timer release];
    [super dealloc];
}


@end
