//
//  ColorRing.m
//  ColorRing
//
//  Created by lingyj on 14-8-26.
//  Copyright (c) 2014年 lingyongjian. All rights reserved.
//

#define count 45

#define kHollowCircleWidth 120.f
#define kHollowCircleWall 30.f

#import "SingleColorRing.h"

@interface SingleColorRing ()
{
    CGFloat inRediu;
    CGFloat outRediu;
    
    CGFloat center;
    
    NSMutableArray *colors;
}

@end

@implementation SingleColorRing

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
        outRediu = frame.size.width - kHollowCircleWall;
        inRediu = frame.size.width - kHollowCircleWall - kHollowCircleWidth;
        
        int m = count/3;
        for (int i = 0 ; i < count ; i++)
        {
            int x = i%m;
            int y = i/m;
            
            CGFloat rgb[3];
            
            rgb[(int)((y+0)%3)] = 0.f;
            rgb[(int)((y+1)%3)] = (float)(m-x)/m;
            rgb[(int)((y+2)%3)] = (float)x/m;
            
            UIColor *c = [UIColor colorWithRed:rgb[0] green:rgb[1] blue:rgb[2] alpha:1];
            [colors addObject:c];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0 ; i < count ; i++)
    {
        CGMutablePathRef pathRef = CGPathCreateMutable();

        CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, center, center);
        CGPathAddArc(pathRef, &CGAffineTransformIdentity, center, center, outRediu/2, M_PI*2*1.f/count*i, M_PI*2*1.f/count*(i+1), NO);
        CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, center, center);
        CGPathAddArc(pathRef, &CGAffineTransformIdentity, center, center, inRediu/2, M_PI*2*1.f/count*i, M_PI*2*1.f/count*(i+1), NO);
        CGContextAddPath(context, pathRef);
        CGContextSetFillColorWithColor(context, [colors[i] CGColor]);
        CGContextDrawPath(context, kCGPathEOFill);
        CGPathRelease(pathRef);
    }
}

@end
