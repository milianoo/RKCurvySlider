//
//  RKCurvySlider.m
//  RKCurvySlider
//
//  Created by Milad Rezazadeh on 5/26/13.
//  Copyright (c) 2013 Milad Rezazadeh. All rights reserved.
//

#import "RKCurvySlider.h"

#define degreesToRadians(x) (M_PI * x / 180.0)
#define P(x,y) CGPointMake(x, y)

@implementation RKCurvySlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Points to Draw Bezier Curve
        CGPoint p1 = P(20, 425);
        CGPoint p2 = P(160, 405);
        CGPoint p3 = P(160, 405);
        CGPoint p4 = P(300,425);
        
        curvePoints = [[NSMutableDictionary alloc] init];
        // Define Points Over Bezier Curve
        for (CGFloat t = 0.0; t <= 1.00001; t += 0.005)
        {
            //represents one single point
            CGPoint point = CGPointMake(bezierInterpolation(t, p1.x, p2.x, p3.x, p4.x), bezierInterpolation(t, p1.y, p2.y, p3.y, p4.y));
            
            //add the point to array
            int x = (int)point.x;
            [curvePoints setValue:[NSString stringWithFormat:@"%f",point.y] forKey:[NSString stringWithFormat:@"%i",x]];
            
             //draw the point as circle to visualize bezier curve's path
             /*
             UIBezierPath *pointPath = [UIBezierPath bezierPathWithArcCenter:point radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
             CAShapeLayer* p = [CAShapeLayer layer];
             p.path = pointPath.CGPath;
             p.strokeColor = [UIColor redColor].CGColor;
             p.lineWidth = 1.0;
             [self.mainview.layer addSublayer:p];
             */
        }
        
    }
    return self;
}

// for bezier calculation
CGFloat bezierInterpolation(CGFloat t, CGFloat a, CGFloat b, CGFloat c, CGFloat d)
{
    CGFloat t2 = t * t;
    CGFloat t3 = t2 * t;
    return a + (-a * 3 + t * (3 * a - a * t)) * t
    + (3 * b + t * (-6 * b + b * 3 * t)) * t
    + (c * 3 - c * 3 * t) * t2
    + d * t3;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isShapeSelected = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchlocation = [[touches anyObject] locationInView:self];
    CGPoint viewPoint = [btn_slider convertPoint:touchlocation fromView:self];
    if ([btn_slider pointInside:viewPoint withEvent:event])
    {
        isShapeSelected = YES;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isShapeSelected)
    {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:touch.view];
        
        int x = (int)location.x;
        
        NSString* y_point = [curvePoints valueForKey:[NSString stringWithFormat:@"%i",x]];
        if (y_point != nil)
            btn_slider.center = P(location.x,[y_point intValue]);
    }
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}


@end
