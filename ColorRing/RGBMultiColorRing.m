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

#define kRingCount 50

#import "RGBMultiColorRing.h"

@interface RGBMultiColorRing ()
{
    CGFloat ringWidth;
    
    CGFloat center;
    
    NSMutableArray *colors;
}

@end

@implementation RGBMultiColorRing

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
        
        int m = count/3;
        for (int i = 0 ; i < count ; i++)
        {
            int x = i%m;
            int y = i/m;
            
            CGFloat rgb[3];
            
            rgb[(int)((y+1)%3)] = (float)(m-x)/m;
            rgb[(int)((y+2)%3)] = (float)x/m;
            rgb[(int)((y+0)%3)] = 0;

            NSMutableArray *ary = [NSMutableArray array];
            
            for (int j = 0 ; j < kRingCount ; j++)
            {
//                rgb[(int)((y+0)%3)] = ((float)(kRingCount-j))/kRingCount;
                rgb[(int)((y+0)%3)] = 0;

                UIColor *c = [UIColor colorWithRed:rgb[0] green:rgb[1] blue:rgb[2] alpha:1];
                [ary addObject:c];
            }
            [colors addObject:ary];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0 ; i < count ; i++)
    {
        for (int j = 0 ; j < kRingCount ; j++)
        {
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, center, center);
            CGPathAddArc(pathRef, &CGAffineTransformIdentity, center, center, ringWidth*j, M_PI*2*1.f/count*i, M_PI*2*1.f/count*(i+1), NO);
            CGPathMoveToPoint(pathRef, &CGAffineTransformIdentity, center, center);
            CGPathAddArc(pathRef, &CGAffineTransformIdentity, center, center, ringWidth*(j+1), M_PI*2*1.f/count*i, M_PI*2*1.f/count*(i+1), NO);
            CGContextAddPath(context, pathRef);
            CGContextSetFillColorWithColor(context, [colors[i][j] CGColor]);
            CGContextDrawPath(context, kCGPathEOFill);
            CGPathRelease(pathRef);
        }
    }
}

@end
