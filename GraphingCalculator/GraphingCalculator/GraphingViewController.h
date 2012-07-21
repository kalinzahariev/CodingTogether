//
//  GraphingViewController.h
//  GraphingCalculator
//
//  Created by Kalin Zahariev on 7/21/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphingViewController : UIViewController

@property (nonatomic, strong) id program;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
