//
//  CircleProgress.m
//  ColorRing
//
//  Created by lingyj on 14-9-18.
//  Copyright (c) 2014年 lingyongjian. All rights reserved.
//

#import "CircleProgress.h"

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kProgressCircleWidth 14.f
#define kProgressCircleColor 0xfff000
#define kBorderWidth 2.f
#define kBorderColor 0x000fff

@interface CircleProgress ()
{
    CGFloat _progress;
}

@end

@implementation CircleProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        
    }
    return self;
}

- (void)reloadWithProgress:(CGFloat)progress
{
    if (progress != _progress)
    {
        _progress = progress;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, self.frame.size.width/2, self.frame.size.height/2);
    CGPathAddArc(pathRef, &CGAffineTransformIdentity, self.frame.size.width/2, self.frame.size.height/2, kProgressCircleWidth+kBorderWidth, 0, M_PI*2, NO);
    CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, self.frame.size.width/2, self.frame.size.height/2);
    CGPathAddArc(pathRef, &CGAffineTransformIdentity, self.frame.size.width/2, self.frame.size.height/2, kProgressCircleWidth, 0, M_PI*2, NO);
    CGContextAddPath(context, pathRef);
    CGContextSetFillColorWithColor(context, [HexRGB(kBorderColor) CGColor]);
    CGContextDrawPath(context, kCGPathEOFill);
    CGPathRelease(pathRef);

    pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, self.frame.size.width/2, self.frame.size.height/2);
    CGPathAddArc(pathRef, &CGAffineTransformIdentity, self.frame.size.width/2, self.frame.size.height/2, kProgressCircleWidth, -M_PI/2, -M_PI/2+M_PI*2*_progress, NO);
    CGContextAddPath(context, pathRef);
    CGContextSetFillColorWithColor(context, [HexRGB(kProgressCircleColor) CGColor]);
    CGContextDrawPath(context, kCGPathEOFill);
    CGPathRelease(pathRef);
}

@end
