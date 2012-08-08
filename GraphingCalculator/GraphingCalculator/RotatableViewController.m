//
//  RotatableViewController.m
//  GraphingCalculator
//
//  Created by mac on 8/5/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import "RotatableViewController.h"

@interface RotatableViewController ()

@end

@implementation RotatableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
