//
//  ViewController.m
//  OutletsTest
//
//  Created by Руслан on 12.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    //self.testView.backgroundColor = [self randomColor];
    //self.testView2.backgroundColor = [self randomColor];
    
    for (UIView *testView in self.testViews) {
        testView.backgroundColor = [self randomColor];
    }
    
}

@end
