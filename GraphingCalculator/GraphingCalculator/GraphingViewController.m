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
@property (nonatomic, weak) IBOutlet UIToolbar * toolbar;
@end

@implementation GraphingViewController
@synthesize program = _program;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize origin = _origin;
@synthesize scale = _scale;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;
@synthesize toolbar = _toolbar;



-(void) setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem {
    if (_splitViewBarButtonItem != splitViewBarButtonItem) {
        NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
        if (_splitViewBarButtonItem) {
            [toolbarItems removeObject:_splitViewBarButtonItem];
        }
        if (splitViewBarButtonItem) {
            [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
        }
        self.toolbar.items = toolbarItems;
        _splitViewBarButtonItem = splitViewBarButtonItem;  
    }
}
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

-(void)setProgram:(id)program {
    if (_program != program) {
        _program = program;
        self.descriptionLabel.text = [CalculatorBrain descriptionOfProgram:self.program];
        [self.view setNeedsDisplay];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // load origin and scale from UserDefaults
    CGRect bounds = self.view.bounds;
    
    GraphingView *graphingView = (GraphingView *) self.view;
    graphingView.graphOrigin = CGPointMake(bounds.origin.x + bounds.size.width/2, bounds.origin.y + bounds.size.height/2);
    graphingView.graphScale = 1.0;
    // populate descrition
    self.descriptionLabel.text = [CalculatorBrain descriptionOfProgram:self.program];
    
    graphingView.delegate = self;
    
    // add gesture recognizers
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:graphingView action:@selector(pinchGestureResponder:)];
    [graphingView addGestureRecognizer:pinchGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:graphingView action:@selector(panGestureResponder:)];
    [graphingView addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *trippleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:graphingView action:@selector(trippleTapGestureResponder:)];
    trippleTapGestureRecognizer.numberOfTapsRequired = 3;
    [graphingView addGestureRecognizer:trippleTapGestureRecognizer];

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
    return YES;
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
