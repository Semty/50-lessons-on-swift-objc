//
//  ViewController.m
//  HW19
//
//  Created by Руслан on 10.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *squads;

@end

@implementation ViewController

//                                                  *** LEARNER && STUDENT && MASTER && SUPERMAN ***

#pragma mark - Main view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *chessBlackSquad = [[UIView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - self.view.frame.size.width) / 2,
                                                                       self.view.frame.size.width, self.view.frame.size.width)];
    chessBlackSquad.backgroundColor = [UIColor blackColor];
    chessBlackSquad.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                       UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:chessBlackSquad];
    
    CGRect whiteSquad = chessBlackSquad.bounds;
    whiteSquad.origin.x += 2;
    whiteSquad.origin.y += 2;
    whiteSquad.size = CGSizeMake(self.view.frame.size.width - 4, self.view.frame.size.width - 4);
    
    UIView *whiteChessSquad = [[UIView alloc] initWithFrame:whiteSquad];
    whiteChessSquad.backgroundColor = [UIColor whiteColor];
    [chessBlackSquad addSubview:whiteChessSquad];
    
    for (NSUInteger i = 0; i < 8; i++) {
        if (i % 2 == 0) {
            [self createChessColumnWithRowIndex:i columnIndex:0 andSuperView:whiteChessSquad];
        } else {
            [self createChessColumnWithRowIndex:i columnIndex:1 andSuperView:whiteChessSquad];
        }
    }
    self.squads = whiteChessSquad;
}

#pragma mark - Supported orientations

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Helpful functions

- (void) createChessColumnWithRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex andSuperView:(UIView *)superView {
    
    for (NSUInteger j = columnIndex; j < 8; j += 2) {
        UIView *blackSquad = [[UIView alloc] initWithFrame:CGRectMake(1 + (superView.frame.size.width - 2) / 8 * rowIndex,
                                                                      1 + (superView.frame.size.height - 2) / 8 * j,
                                                                      (superView.frame.size.width - 2) / 8, (superView.frame.size.height - 2) / 8)];
        blackSquad.backgroundColor = [UIColor blackColor];
        [superView addSubview:blackSquad];
        
        if (j != 3 && j != 4) {
            UIView *smallSquad = [[UIView alloc] initWithFrame:CGRectMake(blackSquad.frame.origin.x + blackSquad.frame.size.width / 4,
                                                                          blackSquad.frame.origin.y + blackSquad.frame.size.height / 4,
                                                                          (superView.frame.size.width - 2) / 16, (superView.frame.size.height - 2) / 16)];
            smallSquad.backgroundColor = [UIColor yellowColor];
            [superView addSubview:smallSquad];
        }
    }
    
}

- (void) changeColorOfSquads:(UIView *)squads {
    
    UIColor *randomColor = [[UIColor alloc] init];
    
    switch (arc4random() % 8) {
        case 0:
            randomColor = [UIColor orangeColor];
            break;
        case 1:
            randomColor = [UIColor greenColor];
            break;
        case 2:
            randomColor = [UIColor redColor];
            break;
        case 3:
            randomColor = [UIColor blueColor];
            break;
        case 4:
            randomColor = [UIColor purpleColor];
            break;
        case 5:
            randomColor = [UIColor lightGrayColor];
            break;
        case 6:
            randomColor = [UIColor magentaColor];
            break;
        case 7:
            randomColor = [UIColor blackColor];
            break;
        default:
            break;
    }
    
    for (UIView *squad in squads.subviews) {
        if (squad.bounds.size.height == (squads.frame.size.width - 2) / 8) {
            squad.backgroundColor = randomColor;
        }
    }
    
}

#pragma mark - Rotate display

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self changeColorOfSquads:self.squads];
    
}

#pragma mark - Others

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
