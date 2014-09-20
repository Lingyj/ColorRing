//
//  ViewController.m
//  ColorRing
//
//  Created by lingyj on 14-8-26.
//  Copyright (c) 2014年 lingyongjian. All rights reserved.
//

#import "ViewController.h"
#import "SingleColorRing.h"
#import "RGBMultiColorRing.h"
#import "HSLMultiColorRing.h"

#import "CircleProgress.h"

@interface ViewController ()
{
    SingleColorRing *scr;
    RGBMultiColorRing *rmcr;
    HSLMultiColorRing *hmcr;
    CGAffineTransform beginTransform;
    
    __weak IBOutlet UISlider *s;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CircleProgress *p = [[CircleProgress alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:p];
    [p reloadWithProgress:0.45];
    
    
//    scr = [[SingleColorRing alloc] initWithFrame:self.view.frame];
//    scr.center = self.view.center;
//    [self.view addSubview:scr];
//    beginTransform = scr.transform;
    
//    rmcr = [[RGBMultiColorRing alloc] initWithFrame:self.view.frame];
//    rmcr.center = self.view.center;
//    [self.view addSubview:rmcr];
//    beginTransform = rmcr.transform;
    
//    hmcr = [[HSLMultiColorRing alloc] initWithFrame:self.view.frame];
//    hmcr.center = self.view.center;
//    [self.view addSubview:hmcr];
//    beginTransform = hmcr.transform;
//
//    [NSTimer scheduledTimerWithTimeInterval:.1f target:self selector:@selector(transform) userInfo:nil repeats:YES];
}

- (void)transform
{
    static int i = 0;
    
    if (i < 36)
    {
        i++;
    }
    else
    {
        i = 0;
    }
    
    CGAffineTransform transform = CGAffineTransformRotate(beginTransform, (M_PI*2)*(float)i/36);
//    scr.transform = transform;
    hmcr.transform = transform;
}

- (IBAction)valueChanged:(id)sender
{
    hmcr.brightness = [(UISlider *)sender value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
