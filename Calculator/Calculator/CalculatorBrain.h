//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Kalin Zahariev on 7/3/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void) pushOperand:(id) operand;
-(double) performOperation:(NSString *) operation;
-(void) clearState;
-(void) removeTopOfStack;

@property (readonly) id program;
+(double) runProgram:(id)program;
+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+(NSString *)descriptionOfProgram:(id)program;	
+ (NSSet *)variablesUsedInProgram:(id)program;
@end
