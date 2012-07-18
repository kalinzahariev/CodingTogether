//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Kalin Zahariev on 7/2/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *headsUpDisplay;
@property (weak, nonatomic) IBOutlet UILabel *variablesDisplay;

@end
