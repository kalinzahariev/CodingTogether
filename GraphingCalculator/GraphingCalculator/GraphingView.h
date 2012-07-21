//
//  GraphingView.h
//  GraphingCalculator
//
//  Created by Kalin Zahariev on 7/21/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GraphingData <NSObject>

-(double) dataForValue:(double)value;

@end

@interface GraphingView : UIView

@property (nonatomic, strong) id <GraphingData> delegate;
@property CGPoint graphOrigin;
@property CGFloat graphScale;

@end
