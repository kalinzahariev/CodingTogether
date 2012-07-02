//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Kalin Zahariev on 7/3/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void) pushOperand:(double) operand;
-(double) performOperation:(NSString *) operation;
@end
