//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Kalin Zahariev on 7/3/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()
@property (nonatomic, strong) NSMutableArray *programStack;
+(BOOL) isValidOperation:(NSString *)operation;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

-(NSMutableArray *) programStack {
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

-(void) pushOperand:(id) operand {
    /* let's leave this for now
    if ([operand isKindOfClass:[NSNumber class]]) {
        NSNumber *operandObject = [NSNumber numberWithDouble:operand];
        [self.programStack addObject:operandObject];
    } else if ([operand isKindOfClass:[NSString class]]) {
        [self.programStack addObject:operand];
    } 
     */
    [self.programStack addObject:operand];
}

-(double) performOperation:(NSString *) operation {
    
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id) program {
    return [self.programStack copy];
}

+(NSString *)descriptionOfProgram:(id)program {
    return @"Not Implemented";
}


//N.B. When adding an operation, make sure you also add it to the method below!
//-(BOOL) isValidOperation:(NSString *)operation
+(double) popOperandOffStack:(NSMutableArray *)stack {
    double result = 0;
    id topOfStack = [stack lastObject];
    if (topOfStack) {
        [stack removeLastObject];
    }
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack ] * [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) {
                result = [self popOperandOffStack:stack] / divisor;
            } 
        } else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"sqrt"]) {
            result = sqrt([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"PI"]) {
            result = M_PI;
        } else if ([operation isEqualToString:@"+/-"]) {
            result = -1 * [self popOperandOffStack:stack];
        }
    }
    
    return result;
}

+(BOOL) isValidOperation:(NSString *)operation
{
    if ([operation isEqualToString:@"+"]) {
        return YES;
    } else if ([operation isEqualToString:@"*"]) {
        return YES;
    } else if ([operation isEqualToString:@"-"]) {
        return YES;
    } else if ([operation isEqualToString:@"/"]) {
        return YES;
    } else if ([operation isEqualToString:@"sin"]) {
        return YES;
    } else if ([operation isEqualToString:@"cos"]) {
        return YES;
    } else if ([operation isEqualToString:@"sqrt"]) {
        return YES;
    } else if ([operation isEqualToString:@"PI"]) {
        return YES;
    } else if ([operation isEqualToString:@"+/-"]) {
        return YES;
    }
    
    return NO;
}


+(double) runProgram:(id)program {
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack: stack];
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues {
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    
    // replace variable names with values
    for (int i=0; i < [stack count]; i++) {
        if ([[stack objectAtIndex:i] isKindOfClass:[NSString class]]) {
            NSString *stringValue = [stack objectAtIndex:i];
            if (![self isValidOperation:stringValue]) {
                NSNumber *value = [variableValues objectForKey:[program objectAtIndex:i]];
                if (value) {
                    [stack replaceObjectAtIndex:i withObject:value];
                } else {
                    [stack replaceObjectAtIndex:i withObject:[NSNumber numberWithDouble:0]];
                }
            }
        }
    }
    
    return [self popOperandOffStack:stack];
}


-(void) clearState {
    [self.programStack removeAllObjects];
}












@end
