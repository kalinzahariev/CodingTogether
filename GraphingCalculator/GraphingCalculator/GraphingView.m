//
//  GraphingView.m
//  GraphingCalculator
//
//  Created by Kalin Zahariev on 7/21/12.
//  Copyright (c) 2012 Kalin Zahariev. All rights reserved.
//

#import "GraphingView.h"
#import "AxesDrawer.h"

@implementation GraphingView
@synthesize delegate = _delegate;
@synthesize graphOrigin = _graphOrigin;
@synthesize graphScale = _graphScale;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // first, get the number of pixels

    // now draw the axes
    [AxesDrawer drawAxesInRect:rect originAtPoint:self.graphOrigin scale:self.graphScale];

    
    // then for each pixel - get the calculated value and draw it
    
}


@end
