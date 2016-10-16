//
//  ViewController.m
//  TouchesTest
//
//  Created by Руслан on 16.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *draggingView;
@property (assign, nonatomic) CGPoint touchOffset;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 8; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 + 110 * i, 100, 100, 100)];
        view.backgroundColor = [self randomColor];
        [self.view addSubview:view];
    }
    //self.view.multipleTouchEnabled = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) logTouches:(NSSet *)touches withMethod:(NSString *)methodName {
    
    NSMutableString *string = [NSMutableString stringWithString:methodName];
    
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    NSLog(@"%@", string);
}

#pragma mark - Privete methods

- (void) onTouchesEnded {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.draggingView.transform = CGAffineTransformIdentity;
                         self.draggingView.alpha = 1.f;
                     }];
    self.draggingView = nil;
    
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

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesBegan"];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint pointOnMainView = [touch locationInView:self.view];
    
    UIView *view = [self.view hitTest:pointOnMainView withEvent:event];
    
    if (![view isEqual:self.view]) {
        
        self.draggingView = view;
        [self.view bringSubviewToFront:self.draggingView];
        
        CGPoint touchOffset = [touch locationInView:self.draggingView];
        
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - touchOffset.x,
                                       CGRectGetMidY(self.draggingView.bounds) - touchOffset.y);
        
        [self.draggingView.layer removeAllAnimations];
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             self.draggingView.alpha = 0.3;
                         }];
        
    } else {
        self.draggingView = nil;
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesMoved"];
    if (self.draggingView) {
        
        UITouch *touch = [touches anyObject];
        
        CGPoint pointOnMainView = [touch locationInView:self.view];
        
        CGPoint correction = CGPointMake(pointOnMainView.x + self.touchOffset.x,
                                         pointOnMainView.y + self.touchOffset.y);
        
        self.draggingView.center = correction;
    }
    

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesEnded"];
    [self onTouchesEnded];
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesCancelled"];
    [self onTouchesEnded];

}

@end
