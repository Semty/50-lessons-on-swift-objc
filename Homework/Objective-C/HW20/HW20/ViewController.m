//
//  ViewController.m
//  HW20
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

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    UIColor *randomColor = [self randomColor];
    for (UIView *blackSquad in self.chessTable) {
        blackSquad.backgroundColor = randomColor;
    }
    
    for (int i = 0; i < [self.smallSquadsFirst count]; i++) {
        
        UIView *smallSquads1 = self.smallSquadsFirst[i];
        UIView *smallSquads2 = self.smallSquadsSecond[i];
        
        CGRect smallSquadsFrame1 = smallSquads1.frame;
        CGRect smallSquadsFrame2 = smallSquads2.frame;
        
        [UIView animateWithDuration:1 animations:^{
            
            [smallSquads1 setFrame:smallSquadsFrame2];
            [smallSquads2 setFrame:smallSquadsFrame1];
        }];
    }
}


@end
