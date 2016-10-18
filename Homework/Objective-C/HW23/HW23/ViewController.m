//
//  ViewController.m
//  HW23
//
//  Created by Руслан on 18.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (assign, nonatomic) CGFloat ballScale;
@property (assign, nonatomic) CGFloat ballRotation;

#define pi 3.14
#define minus_pi -3.14

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tap gesture
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    // right swipe gesture
    UISwipeGestureRecognizer *swipeRightGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleSwipeRight:)];
    
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
    // left swipe gesture
    UISwipeGestureRecognizer *swipeLeftGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleSwipeLeft:)];
    
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    // double tap gesture
    UITapGestureRecognizer *tapDoubleGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTapDouble:)];
    tapDoubleGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapDoubleGesture];
    
    [tapGesture requireGestureRecognizerToFail:tapDoubleGesture];
    
    
    // pinch gesture
    UIPinchGestureRecognizer *pinchGesture =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    
    [self.view addGestureRecognizer:pinchGesture];
    
    // rotation gesture
    UIRotationGestureRecognizer *rotationGesture =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    
    [self.view addGestureRecognizer:rotationGesture];
}

#pragma mark - Helpful functions

- (void) rotateView:(UIView *)view withAngle:(CGFloat)angle
         andAnimationDuration:(NSTimeInterval)animationDuration usingFullCircle:(BOOL)fullCircle {
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.ball.transform = CGAffineTransformRotate(self.ball.transform, angle);
                     }
                     completion:^(BOOL finished) {
                         if (fullCircle) {
                             [self rotateView:self.ball withAngle:angle
                                   andAnimationDuration:animationDuration usingFullCircle:NO];
                         }
                     }];
}

#pragma mark - Touches

- (void) handleTap:(UITapGestureRecognizer *)tapGesture {
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.ball.center = [tapGesture locationInView:self.view];
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void) handleSwipeRight:(UISwipeGestureRecognizer *)swipeRightGesture {
    
    NSLog(@"handleSwipeRight");
    
    [self rotateView:self.ball withAngle:pi andAnimationDuration:0.5f usingFullCircle:YES];
}

- (void) handleSwipeLeft:(UISwipeGestureRecognizer *)swipeLeftGesture {
    
    NSLog(@"handleSwipeLeft");
    
    [self rotateView:self.ball withAngle:minus_pi andAnimationDuration:0.5f usingFullCircle:YES];
}

- (void) handleTapDouble:(UITapGestureRecognizer *)tapDoubleGesture {
    NSLog(@"handleTapDouble");
    [self.ball.layer removeAllAnimations];
}

- (void) handlePinch:(UIPinchGestureRecognizer *)pinchGesture {
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.ballScale = 1.f;
    }
    
    CGFloat scale = 1.f + pinchGesture.scale - self.ballScale;
    
    self.ball.transform = CGAffineTransformScale(self.ball.transform, scale, scale);
    
    self.ballScale = pinchGesture.scale;
}

- (void) handleRotation:(UIRotationGestureRecognizer *)rotationGesture {
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.ballRotation = 0.f;
    }
    
    CGFloat rotation = rotationGesture.rotation - self.ballRotation;
    
    self.ball.transform = CGAffineTransformRotate(self.ball.transform, rotation);
    
    self.ballRotation = rotationGesture.rotation;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
        shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
