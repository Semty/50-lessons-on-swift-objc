//
//  ViewController.m
//  GesturesTest
//
//  Created by Руслан on 17.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView *testView;
@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;
@property (assign, nonatomic) CGPoint testViewCorrection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 50,
                                                            CGRectGetMidY(self.view.bounds) - 50,
                                                            100, 100)];
    
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                            UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    self.testView = view;
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapDoubleGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTap:)];
    tapDoubleGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapDoubleGesture];
    
    UITapGestureRecognizer *tapDoubleTouchDoubleGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTapDoubleTouch:)];
    tapDoubleTouchDoubleGesture.numberOfTapsRequired = 2;
    tapDoubleTouchDoubleGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tapDoubleTouchDoubleGesture];
    
    [tapGesture requireGestureRecognizerToFail:tapDoubleGesture];
    
    
    UIPinchGestureRecognizer *pinchGesture =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    
    UIRotationGestureRecognizer *rotationGesture =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
    
    UIPanGestureRecognizer *panGesture =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlePan:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    
    UISwipeGestureRecognizer *swipeVerticalGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSwipeVertical:)];
    swipeVerticalGesture.direction =
    UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    
    swipeVerticalGesture.delegate = self;
    
    [self.view addGestureRecognizer:swipeVerticalGesture];
    
    
    UISwipeGestureRecognizer *swipeHorizontalGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSwipeHorizontal:)];
    swipeHorizontalGesture.direction =
    UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    
    swipeHorizontalGesture.delegate = self;
    
    [self.view addGestureRecognizer:swipeHorizontalGesture];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Private methods

- (UIColor *) randomColor {
    
    CGFloat r = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat g = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat b = (CGFloat)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (BOOL) isPoint:(CGPoint)point inView:(UIView *)view {
    
    if (CGRectContainsPoint(view.frame, point)) {
        return YES;
    } else {
        return NO;
    }
    
}

#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer *)tapGesture {
    
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    if ([self isPoint:[tapGesture locationInView:self.view] inView:self.testView]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.testView.backgroundColor = [self randomColor];
                         }];
    }
}

- (void) handleDoubleTap:(UITapGestureRecognizer *)tapGesture {
    
    NSLog(@"Double tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    if ([self isPoint:[tapGesture locationInView:self.view] inView:self.testView]) {
        
        CGAffineTransform currentTransform = self.testView.transform;
        CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.2, 1.2);
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.testView.transform = newTransform;
                         }];
        self.testViewScale = 1.2f;
    }
    
}

- (void) handleDoubleTapDoubleTouch:(UITapGestureRecognizer *)tapGesture {
    
    NSLog(@"Double tap and double touch: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    if ([self isPoint:[tapGesture locationInView:self.view] inView:self.testView]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.testView.transform = CGAffineTransformIdentity;
                         }];
        self.testViewScale = 1.f;
    }
}

- (void) handlePinch:(UIPinchGestureRecognizer *)pinchGesture {
    
    NSLog(@"Pinch: %1.3f", pinchGesture.scale);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1.f;
    }
    
    CGFloat newScale = 1.0 + pinchGesture.scale - self.testViewScale;
    
    CGAffineTransform currentTransform = self.testView.transform;
    
    CGAffineTransform newTransform =
    CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.testView.transform = newTransform;
    self.testViewScale = pinchGesture.scale;
}

- (void) handleRotation:(UIRotationGestureRecognizer *)rotationGesture {
    
    NSLog(@"Rotation: %1.3f", rotationGesture.rotation);
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0.f;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.testViewRotation;
    
    CGAffineTransform currentTransform = self.testView.transform;
    
    CGAffineTransform newTransform =
    CGAffineTransformRotate(currentTransform, newRotation);

    self.testView.transform = newTransform;
    self.testViewRotation = rotationGesture.rotation;
}

- (void) handlePan:(UIRotationGestureRecognizer *)panGesture {
    
    NSLog(@"Pan");
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        
        self.testViewCorrection = CGPointMake(CGRectGetMidX(self.testView.frame) - [panGesture locationInView:self.view].x,
                                              CGRectGetMidY(self.testView.frame) - [panGesture locationInView:self.view].y);
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.testView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             self.testView.alpha = 0.4f;
                         }];
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.testView.transform = CGAffineTransformIdentity;
                             self.testView.alpha = 1.f;
                         }];

    }
    
    self.testView.center = CGPointMake([panGesture locationInView:self.view].x + self.testViewCorrection.x,
                                       [panGesture locationInView:self.view].y + self.testViewCorrection.y);
    
}

- (void) handleSwipeVertical:(UIRotationGestureRecognizer *)swipeGesture {
    
    NSLog(@"Vertical swipe");
    
}

- (void) handleSwipeHorizontal:(UIRotationGestureRecognizer *)swipeGesture {
    
    NSLog(@"Horizontal swipe");
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
        shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
    

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
        shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
           [otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]] ? YES : NO;
}


@end
