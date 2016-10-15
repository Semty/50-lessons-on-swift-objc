//
//  ViewController.m
//  HW21
//
//  Created by Руслан on 14.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIImageView *runner;
@property (weak, nonatomic) UIView *squad1;
@property (weak, nonatomic) UIView *squad2;
@property (weak, nonatomic) UIView *squad3;
@property (weak, nonatomic) UIView *squad4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *runner = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    
    UIImage *image1 = [UIImage imageNamed:@"png_1"];
    UIImage *image2 = [UIImage imageNamed:@"png_2"];
    UIImage *image3 = [UIImage imageNamed:@"png_3"];
    UIImage *image4 = [UIImage imageNamed:@"png_4"];
    UIImage *image5 = [UIImage imageNamed:@"png_5"];
    UIImage *image6 = [UIImage imageNamed:@"png_6"];
    UIImage *image7 = [UIImage imageNamed:@"png_7"];
    UIImage *image8 = [UIImage imageNamed:@"png_8"];
    UIImage *image9 = [UIImage imageNamed:@"png_9"];
    UIImage *image10 = [UIImage imageNamed:@"png_10"];
    
    NSArray *images = @[ image1, image2, image3, image4, image5, image6, image7, image8, image9, image10 ];
    
    runner.animationImages = images;
    runner.animationDuration = 0.5f;
    runner.transform = CGAffineTransformMakeRotation(M_PI);
    [runner startAnimating];
    [self.view addSubview:runner];
    self.runner = runner;
    
    /*
    UIView *squad1 = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView *squad2 = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView *squad3 = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView *squad4 = [[UIView alloc] initWithFrame:self.view.bounds];
    
    squad1.frame = CGRectMake(CGRectGetMinX(self.view.bounds),
                              CGRectGetMinY(self.view.bounds),
                              CGRectGetWidth(self.view.bounds) / 4,
                              CGRectGetWidth(self.view.bounds) / 4);
    
    squad2.frame = CGRectMake(CGRectGetMinX(self.view.bounds),
                              CGRectGetMinY(squad1.frame) + squad1.frame.size.height,
                              CGRectGetWidth(squad1.frame), CGRectGetHeight(squad1.frame));
    
    squad3.frame = CGRectMake(CGRectGetMinX(self.view.bounds),
                              CGRectGetMinY(squad2.frame) + squad2.frame.size.height,
                              CGRectGetWidth(squad2.frame), CGRectGetHeight(squad2.frame));
    
    squad4.frame = CGRectMake(CGRectGetMinX(self.view.bounds),
                              CGRectGetMinY(squad3.frame) + squad3.frame.size.height,
                              CGRectGetWidth(squad3.frame), CGRectGetHeight(squad3.frame));
    
    squad1.backgroundColor = [self randomColor];
    squad2.backgroundColor = [self randomColor];
    squad3.backgroundColor = [self randomColor];
    squad4.backgroundColor = [self randomColor];
    
    [self.view addSubview:squad1];
    [self.view addSubview:squad2];
    [self.view addSubview:squad3];
    [self.view addSubview:squad4];
    
    self.squad1 = squad1;
    self.squad2 = squad2;
    self.squad3 = squad3;
    self.squad4 = squad4;
    */
    
    CGFloat inWindow = CGRectGetWidth(self.view.bounds) / 5;
    
    UIView *squad1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds) + inWindow,
                                                              CGRectGetMinY(self.view.bounds) + inWindow,
                                                              CGRectGetWidth(self.view.bounds) / 5,
                                                              CGRectGetWidth(self.view.bounds) / 5)];
    
    UIView *squad2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds)
                                                              - CGRectGetWidth(self.view.bounds) / 5 - inWindow,
                                                              CGRectGetMinY(self.view.bounds) + inWindow,
                                                              CGRectGetWidth(self.view.bounds) / 5,
                                                              CGRectGetWidth(self.view.bounds) / 5)];

    UIView *squad3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds)
                                                              - CGRectGetWidth(self.view.bounds) / 5 - inWindow,
                                                              CGRectGetMaxY(self.view.bounds)
                                                              - CGRectGetWidth(self.view.bounds) / 5 - inWindow,
                                                              CGRectGetWidth(self.view.bounds) / 5,
                                                              CGRectGetWidth(self.view.bounds) / 5)];
    
    UIView *squad4 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds) + inWindow,
                                                              CGRectGetMaxY(self.view.bounds)
                                                              - CGRectGetWidth(self.view.bounds) / 5 - inWindow,
                                                              CGRectGetWidth(self.view.bounds) / 5,
                                                              CGRectGetWidth(self.view.bounds) / 5)];
    squad1.backgroundColor = [UIColor redColor];
    squad2.backgroundColor = [UIColor yellowColor];
    squad3.backgroundColor = [UIColor greenColor];
    squad4.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:squad1];
    [self.view addSubview:squad2];
    [self.view addSubview:squad3];
    [self.view addSubview:squad4];
    
    self.squad1 = squad1;
    self.squad2 = squad2;
    self.squad3 = squad3;
    self.squad4 = squad4;
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /*
    [self moveSquad:self.squad1 withAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self moveSquad:self.squad2 withAnimationCurve:UIViewAnimationOptionCurveEaseOut];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self moveSquad:self.squad3 withAnimationCurve:UIViewAnimationOptionCurveEaseIn];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self moveSquad:self.squad4 withAnimationCurve:UIViewAnimationOptionCurveLinear];
    });
    */
    [self moveSquads];
    
    [self moveTheManToPoint];
}

- (void) moveTheManToPoint {
    
    NSTimeInterval animationDuration = 3;
    
    CGPoint leftTopCenter = self.runner.center;
    CGPoint rightTopCenter = CGPointMake(CGRectGetWidth(self.view.bounds) - self.runner.center.x,
                                         self.runner.center.y);
    CGPoint rightBottomCenter = CGPointMake(CGRectGetWidth(self.view.bounds) - self.runner.center.x,
                                            CGRectGetHeight(self.view.bounds) - self.runner.center.y);
    CGPoint leftBottomCenter = CGPointMake(self.runner.center.x,
                                           CGRectGetHeight(self.view.bounds) - self.runner.center.y);
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.runner.center = rightTopCenter;
                     }
                     completion:^(BOOL finished) {
                         self.runner.transform = CGAffineTransformMakeRotation(-(M_PI_2));
                         
                     }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.runner.center = rightBottomCenter;
                         }
                         completion:^(BOOL finished) {
                             self.runner.transform = CGAffineTransformMakeRotation((M_PI * 2));
                         }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((animationDuration * 2) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.runner.center = leftBottomCenter;
                         }
                         completion:^(BOOL finished) {
                             self.runner.transform = CGAffineTransformMakeRotation(M_PI_2);
                         }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((animationDuration * 3) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:animationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.runner.center = leftTopCenter;
                         }
                         completion:^(BOOL finished) {
                             self.runner.transform = CGAffineTransformMakeRotation(M_PI);
                             [self moveTheManToPoint];
                         }];
    });
    
}

- (void) moveSquads {
    
    NSTimeInterval duration = 2.5;
        
    CGPoint squad1Center = self.squad1.center;
    CGPoint squad2Center = self.squad2.center;
    CGPoint squad3Center = self.squad3.center;
    CGPoint squad4Center = self.squad4.center;
        
    UIColor *squad1Color = self.squad1.backgroundColor;
    UIColor *squad2Color = self.squad2.backgroundColor;
    UIColor *squad3Color = self.squad3.backgroundColor;
    UIColor *squad4Color = self.squad4.backgroundColor;
        
    [self animate:self.squad1 toCenter:squad2Center withColor:squad2Color andDuration:duration];
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animate:self.squad2 toCenter:squad3Center withColor:squad3Color andDuration:duration];
    });
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animate:self.squad3 toCenter:squad4Center withColor:squad4Color andDuration:duration];
    });
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animate:self.squad4 toCenter:squad1Center withColor:squad1Color andDuration:duration];
    });
}

- (void) animate:(UIView *)squad toCenter:(CGPoint)center withColor:(UIColor *)color andDuration:(NSTimeInterval)duration {
    
    CGFloat r = (float)(arc4random() % (int)((M_PI * 4) * 10000)) * 10000 - (M_PI * 2);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                         squad.transform = CGAffineTransformMakeRotation(r);
                         squad.center = center;
                         squad.backgroundColor = color;
                     }
                     completion:^(BOOL finished) {
                         if (color == [UIColor redColor]) {
                             [self moveSquads];
                         }
                     }];
}

- (void) moveSquad:(UIView *)squad withAnimationCurve:(UIViewAnimationOptions)animationCurve {
    /*
    [UIView animateWithDuration:4
                          delay:1
                        options:animationCurve | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         
                         CGRect endRect = CGRectMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(squad.frame),
                                                     CGRectGetMinY(squad.frame),
                                                     CGRectGetWidth(squad.frame),
                                                     CGRectGetHeight(squad.frame));
                         
                         [squad setFrame:endRect];
                         
                     }
                     completion:^(BOOL finished) {
                     }];
    */
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (CGFloat) randomFromZeroToOne {
    return (arc4random() % 256) / 255.f;
}

- (UIColor *) randomColor {
    
    CGFloat r = [self randomFromZeroToOne];
    CGFloat g = [self randomFromZeroToOne];
    CGFloat b = [self randomFromZeroToOne];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
