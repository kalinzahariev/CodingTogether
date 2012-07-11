//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Kalin Zahariev on 7/2/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
 
@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize headsUpDisplay = _headsUpDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CalculatorBrain *)brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc ] init ];
    }
    return _brain;
}


- (IBAction)periodPressed {
    if ([self.display.text rangeOfString:@"."].location == NSNotFound) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit	= sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed {
    NSNumber *operand = [NSNumber numberWithDouble:[self.display.text doubleValue]];
    [self.brain pushOperand:operand];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.headsUpDisplay.text =	 [self.headsUpDisplay.text stringByAppendingFormat:@" %@ ", self.display.text];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.headsUpDisplay.text = [self.headsUpDisplay.text stringByAppendingFormat:@" %@ = ", sender.currentTitle];
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.headsUpDisplay.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain clearState];
}

- (IBAction)deletePressed {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text substringWithRange:NSMakeRange(0, self.display.text.length-1)];
        if (self.display.text.length == 0) {
            self.display.text = @"0";
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
    }
}

- (IBAction)signPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if ([[self.display.text substringToIndex:1] isEqualToString:@"-"]) {
            self.display.text = [self.display.text substringFromIndex:1];
        } else {
            self.display.text = [@"-" stringByAppendingString:self.display.text];
        }
    } else {
        [self operationPressed:sender];
    }
}



- (void)viewDidUnload {
    [self setHeadsUpDisplay:nil];
    [super viewDidUnload];
}








@end
