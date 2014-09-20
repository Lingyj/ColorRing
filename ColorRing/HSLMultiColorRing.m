//
//  ColorRing.m
//  ColorRing
//
//  Created by lingyj on 14-8-26.
//  Copyright (c) 2014年 lingyongjian. All rights reserved.
//

#define count 60

#define kHollowCircleOutRediu 270.f
#define kHollowCircleInRediu 0.f

#define kRingCount 20

#import "HSLMultiColorRing.h"

@interface HSLMultiColorRing ()
{
    CGFloat ringWidth;
    
    CGFloat center;
    
    NSMutableArray *colors;
}

@end

@implementation HSLMultiColorRing

- (id)initWithFrame:(CGRect)frame
{
    int k = count%3;
    assert(k == 0);
    
    frame.size.width = frame.size.height = MIN(frame.size.width, frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        colors = [NSMutableArray arrayWithCapacity:count];
        center = frame.size.width/2;
        ringWidth = (kHollowCircleOutRediu - kHollowCircleInRediu)/kRingCount;

        self.brightness = 0.9f;
    }
    return self;
}

- (void)setBrightness:(CGFloat)brightness
{
    if (_brightness == brightness)
    {
        return;
    }
    
    [colors removeAllObjects];
    _brightness = brightness;
    [self loadColorsWithBrightness:_brightness];
    
    [self setNeedsDisplay];
}

- (void)loadColorsWithBrightness:(CGFloat)brightness
{

    for (int j = 0 ; j < kRingCount ; j++)
    {
        CGFloat saturation = (float)j / kRingCount;
        NSMutableArray *ary = [NSMutableArray array];

        for (int i = 0 ; i < count ; i++)
        {
            CGFloat hue = (float)i / count;
            
            UIColor *c = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.f];
            [ary addObject:c];
        }

        [colors addObject:ary];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0 ; i < kRingCount ; i++)
    {
        for (int j = 0 ; j < count ; j++)
        {
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, center, center);
            CGPathAddArc(pathRef, &CGAffineTransformIdentity, center, center, ringWidth*i, M_PI*2*1.f/count*j, M_PI*2*1.f/count*(j+1), NO);
            CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, center, center);
            CGPathAddArc(pathRef, &CGAffineTransformIdentity, center, center, ringWidth*(i+1), M_PI*2*1.f/count*j, M_PI*2*1.f/count*(j+1), NO);
            CGContextAddPath(context, pathRef);
            CGContextSetFillColorWithColor(context, [colors[i][j] CGColor]);
            
            CGContextDrawPath(context, kCGPathEOFill);
            CGPathRelease(pathRef);
        }
    }
}

@end
