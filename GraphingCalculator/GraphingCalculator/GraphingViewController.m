//
//  GraphingViewController.m
//  GraphingCalculator
//
//  Created by Kalin Zahariev on 7/21/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import "GraphingViewController.h"
#import "CalculatorBrain.h"
#import "GraphingView.h"

@interface GraphingViewController ()
@property CGPoint origin;
@property CGFloat scale;
@end

@implementation GraphingViewController
@synthesize program = _program;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize origin = _origin;
@synthesize scale = _scale;


- (double) dataForValue:(double)value {
    NSDictionary *variables = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithDouble:value], @"x", nil];
    return [CalculatorBrain runProgram:self.program usingVariableValues:variables];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) pinchGestureResponder: (UIPinchGestureRecognizer *) sender {
    if (sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateEnded) {
        GraphingView *graphingView = (GraphingView*)self.view;
        graphingView.graphScale *= sender.scale;
        sender.scale = 1;
        [graphingView setNeedsDisplay];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // load origin and scale from UserDefaults
    CGRect bounds = self.view.bounds;
    
    GraphingView *graphngView = (GraphingView *) self.view;
    graphngView.graphOrigin = CGPointMake(bounds.origin.x + bounds.size.width/2, bounds.origin.y + bounds.size.height/2);
    graphngView.graphScale = 1.0;
    // populate descrition
    self.descriptionLabel.text = [CalculatorBrain descriptionOfProgram:self.program];
    
    graphngView.delegate = self;
    
    // add gesture recognizers
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureResponder:)];
    [graphngView addGestureRecognizer:pinchGestureRecognizer];
    
    
}

- (void)viewDidUnload
{
    [self setDescriptionLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // Save origin and scale to UserDefaults
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
