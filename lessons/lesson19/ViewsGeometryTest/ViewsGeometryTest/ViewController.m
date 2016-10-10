//
//  ViewController.m
//  ViewsGeometryTest
//
//  Created by Руслан on 10.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 130, 200, 50)];
    view1.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
                             UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    view1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 130, 50, 250)];
    view2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.8];
    view2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin |
                             UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:view2];
    
    [self.view bringSubviewToFront:view1];
    
    self.testView = view2;
    
    CGRect r = self.view.frame;
    r.origin.y = 0;
    r.origin.x = CGRectGetWidth(r) - 100;
    r.size = CGSizeMake(100, 100);
    
    UIView *v = [[UIView alloc] initWithFrame:r];
    v.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    v.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
    
    [self.view addSubview:v];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    //NSLog(@"\n\n Frame = %@\n\n Bounds = %@\n\n", NSStringFromCGRect(self.testView.frame), NSStringFromCGRect(self.testView.bounds));
    
    NSLog(@"\n\n Frame = %@\n\n Bounds = %@\n\n", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
    
    CGPoint origin = CGPointZero;
    origin = [self.view convertPoint:origin toView:self.view.window];
    
    NSLog(@"Origin = %@", NSStringFromCGPoint(origin));
}

@end
