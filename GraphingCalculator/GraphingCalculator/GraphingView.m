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

#define POINT_SIZE 0

- (void) drawPointAtX: (NSUInteger) x Y: (NSUInteger) y{
   	CGContextRef context = UIGraphicsGetCurrentContext();
    
	UIGraphicsPushContext(context);
    
	CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, CGRectMake(x-POINT_SIZE, y-POINT_SIZE, 2*POINT_SIZE+1, 2*POINT_SIZE+1));
	CGContextFillPath(context);
    
	UIGraphicsPopContext(); 
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // first, get the number of pixels

    // now draw the axes
    [AxesDrawer drawAxesInRect:rect originAtPoint:self.graphOrigin scale:self.graphScale];

    CGFloat pixelsPerPoint = 1;//[self contentScaleFactor];
    // then for each pixel - get the calculated value and draw it
    for (int i = self.bounds.origin.x*pixelsPerPoint; i < (self.bounds.origin.x + self.bounds.size.width)*pixelsPerPoint; i++) {
        double xValue = (i - self.graphOrigin.x*pixelsPerPoint) / self.graphScale ;
        double yValue = [self.delegate dataForValue:xValue];
        NSUInteger y = self.graphOrigin.y * pixelsPerPoint - (yValue * self.graphScale);
        [self drawPointAtX:i Y: y];
    }
    
}


-(void) pinchGestureResponder: (UIPinchGestureRecognizer *) sender {
    if (sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateEnded) {
        self.graphScale *= sender.scale;
        sender.scale = 1;
        [self setNeedsDisplay];
    }
}

-(void) panGestureResponder: (UIPanGestureRecognizer *) sender {
    if (sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateEnded) {
        CGPoint currentOrigin = self.graphOrigin;
        currentOrigin.x += [sender translationInView:self].x;
        currentOrigin.y += [sender translationInView:self].y;
        
        self.graphOrigin = currentOrigin;
        [sender setTranslation:CGPointMake(0,0) inView:self];
        [self setNeedsDisplay];
    }
}

-(void) trippleTapGestureResponder: (UITapGestureRecognizer *) sender {
    if (sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateEnded) {
        self.graphOrigin = [sender locationInView:self];
        [self setNeedsDisplay];
    }
}


@end
