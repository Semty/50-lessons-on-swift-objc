//
//  ViewController.m
//  DrawingsTest
//
//  Created by Руслан on 19.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import "RTDrawingView.h"

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

#pragma mark - Orientation

- (void) viewWillTransitionToSize:(CGSize)size
         withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self.drawingView setNeedsDisplay];
}


@end
