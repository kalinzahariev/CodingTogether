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
@property (nonatomic, strong) NSDictionary *variableValues;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize headsUpDisplay = _headsUpDisplay;
@synthesize variablesDisplay = _variablesDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize variableValues = _variableValues;

-(CalculatorBrain *)brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc ] init ];
    }
    return _brain;
}

-(NSDictionary *) variableValues {
    if (!_variableValues) {
        _variableValues = [[NSDictionary alloc] init];
    }
    return _variableValues;
}

-(void)setVariableValues:(NSDictionary *)variableValues {
    _variableValues = [variableValues copy];
    
    // update variables display
    self.variablesDisplay.text = @"";
    for (NSString *var in variableValues) {
        self.variablesDisplay.text = [self.variablesDisplay.text stringByAppendingFormat:@"%@=%@, ", var, [variableValues objectForKey:var]];
    }
    
    // now update the calculation result
    double result = [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.variableValues];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.headsUpDisplay.text =	 [CalculatorBrain descriptionOfProgram:self.brain.program];
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
    if (operand.doubleValue == 0 && ![self.display.text isEqualToString:@"0"]) {
        [self.brain pushOperand:self.display.text];
    } else {
        [self.brain pushOperand:operand];
    }
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.headsUpDisplay.text =	 [CalculatorBrain descriptionOfProgram:self.brain.program];
}
- (IBAction)variablePressed:(UIButton *)sender {
    self.display.text = sender.currentTitle;
    //[self.brain pushOperand:sender.currentTitle];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    [self.brain performOperation:sender.currentTitle];
    double result = [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.variableValues];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.headsUpDisplay.text =	 [CalculatorBrain descriptionOfProgram:self.brain.program];
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.headsUpDisplay.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain clearState];
}

// This is the undo button
- (IBAction)deletePressed {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text substringWithRange:NSMakeRange(0, self.display.text.length-1)];
        if (self.display.text.length == 0) {
            double result = [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.variableValues];
            self.display.text = [NSString stringWithFormat:@"%g", result];
            self.headsUpDisplay.text =	 [CalculatorBrain descriptionOfProgram:self.brain.program];
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
    } else {
        [self.brain removeTopOfStack];
        double result = [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.variableValues];
        self.display.text = [NSString stringWithFormat:@"%g", result];
        self.headsUpDisplay.text =	 [CalculatorBrain descriptionOfProgram:self.brain.program];
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

- (IBAction)test1Pressed {
    self.variableValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithInt:1], @"x", 
                           [NSNumber numberWithInt:2], @"y", 
                           [NSNumber numberWithInt:3], @"z", 
                           [NSNumber numberWithInt:4], @"a", 
                           [NSNumber numberWithInt:5], @"b", 
                           [NSNumber numberWithInt:6], @"c", 
                           nil];
}

- (IBAction)test2Pressed {
    self.variableValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithInt:11], @"x", 
                           [NSNumber numberWithInt:12], @"y", 
                           [NSNumber numberWithInt:13], @"z", 
                           [NSNumber numberWithInt:14], @"a", 
                           [NSNumber numberWithInt:15], @"b", 
                           [NSNumber numberWithInt:16], @"c", 
                           nil];
}

- (IBAction)test3Pressed {
    self.variableValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithInt:10], @"x", 
                           [NSNumber numberWithInt:20], @"y", 
                           [NSNumber numberWithInt:30], @"z", 
                           [NSNumber numberWithInt:40], @"a", 
                           [NSNumber numberWithInt:50], @"b", 
                           [NSNumber numberWithInt:60], @"c", 
                           nil];
}

- (void)viewDidUnload {
    [self setHeadsUpDisplay:nil];
    [self setVariablesDisplay:nil];
    [super viewDidUnload];
}








@end
