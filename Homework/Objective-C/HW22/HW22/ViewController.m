//
//  ViewController.m
//  HW22
//
//  Created by Руслан on 16.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *chessTable;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *smallSquadsFirst;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *smallSquadsSecond;
@property (weak, nonatomic) IBOutlet UIView *whiteTable;
@property (weak, nonatomic) UIView *draggingView;
@property (weak, nonatomic) UIView *blackSquadForEnding;
@property (assign, nonatomic) CGPoint touchOffset;
@property (assign, nonatomic) CGPoint lastCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (BOOL) viewIsEqualSmallSquads:(UIView *)view {
    
    for (UIView *squad in self.smallSquadsFirst) {
        if ([squad isEqual:view] ) {
            self.draggingView = squad;
            return YES;
        }
    }
    
    for (UIView *squad in self.smallSquadsSecond) {
        if ([squad isEqual:view] ) {
            self.draggingView = squad;
            return YES;
        }
    }
    
    return NO;
}

- (BOOL) blackSquadIsClear:(UIView *)blackSquad {
    
    for (UIView *smallSquad in self.smallSquadsFirst) {
        if (CGRectContainsRect(blackSquad.frame, smallSquad.frame) && ![smallSquad isEqual:self.draggingView]) {
            return NO;
        }
    }
    
    for (UIView *smallSquad in self.smallSquadsSecond) {
        if (CGRectContainsRect(blackSquad.frame, smallSquad.frame) && ![smallSquad isEqual:self.draggingView]) {
            return NO;
        }
    }
    
    return YES;
}

- (NSInteger) isBlackSquad:(UITouch *)touch withEvent:(UIEvent *)event {
    
    for (UIView *blackSquad in self.chessTable) {
        CGPoint point = [touch locationInView:blackSquad];
        if ([blackSquad pointInside:point withEvent:event]) {
            
            if ([self blackSquadIsClear:blackSquad]) {
                return 1;
            } else {
                return 2;
            }
        }
    }
    
    return 0;
}

- (CGPoint) centerInsideBlackSquad:(UITouch *)touch andEvent:(UIEvent *)event {
    
    for (UIView *blackSquad in self.chessTable) {
        CGPoint point = [touch locationInView:blackSquad];
        if ([blackSquad pointInside:point withEvent:event]) {
            
            CGPoint center = blackSquad.center;
            return center;
        }
    }
    return [touch locationInView:self.whiteTable];
}

- (UIView *) nearBlackSquadUsing:(UITouch *)touch {
    
    UIView *nearBlackSquad = [[UIView alloc] init];
    CGPoint pointInWhiteSquad = [touch locationInView:self.whiteTable];
    double distance = 99999999999999;
    
    for (UIView *blackSquad in self.chessTable) {
        
        CGPoint pointInBlackSquad = blackSquad.center;
        
        double dx = (pointInBlackSquad.x-pointInWhiteSquad.x);
        double dy = (pointInBlackSquad.y-pointInWhiteSquad.y);
        double dist = dx*dx + dy*dy;
        
        if (dist < distance && [self blackSquadIsClear:blackSquad]) {
            nearBlackSquad = blackSquad;
            distance = dist;
        }
    }
    return nearBlackSquad;
}

- (void) returningToTheLastPosition {
    
    NSTimeInterval animationDuration = 0.3;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.draggingView.center = self.lastCenter;
                     }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.draggingView.transform = CGAffineTransformIdentity;
                             self.draggingView.alpha = 1.f;
                             self.draggingView = nil;
                         }];
    });
    
}

- (void) onTouchesEndedWithTouch:(UITouch *)touch andEvent:(UIEvent *)event {
    
    CGPoint point = [touch locationInView:self.whiteTable];
    
    if ([self.whiteTable pointInside:point withEvent:event]) {
        
        if ([self isBlackSquad:touch withEvent:event] == 1) {
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.draggingView.transform = CGAffineTransformIdentity;
                                 self.draggingView.alpha = 1.f;
                                 self.draggingView.center = [self centerInsideBlackSquad:touch andEvent:event];
                                 self.draggingView = nil;
                             }];
        } else if ([self isBlackSquad:touch withEvent:event] == 2) {
            [self returningToTheLastPosition];
        } else {
            UIView *toTheBlackSquad = [self nearBlackSquadUsing:touch];
            [UIView animateWithDuration:0.3 animations:^{
                self.draggingView.transform = CGAffineTransformIdentity;
                self.draggingView.alpha = 1.f;
                self.draggingView.center = toTheBlackSquad.center;
                self.draggingView = nil;
            }];
        }
    } else {
        [self returningToTheLastPosition];
    }
}

#pragma mark - Touches

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint pointOnTheMain = [touch locationInView:self.whiteTable];
    
    UIView *view = [self.whiteTable hitTest:pointOnTheMain withEvent:event];
    
    if ([self viewIsEqualSmallSquads:view]) {
        
        [self.view bringSubviewToFront:self.draggingView];
        
        CGPoint touchOffset = [touch locationInView:self.whiteTable];
        
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingView.frame) - touchOffset.x,
                                       CGRectGetMidY(self.draggingView.frame) - touchOffset.y);
        
        self.lastCenter = self.draggingView.center;
        
        [self.draggingView.layer removeAllAnimations];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.draggingView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            self.draggingView.alpha = 0.75;
        }];
        
    } else {
        self.draggingView = nil;
    }
    
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.draggingView) {
        UITouch *touch = [touches anyObject];
        
        CGPoint pointOnTheMain = [touch locationInView:self.whiteTable];
        
        CGPoint correction = CGPointMake(pointOnTheMain.x + self.touchOffset.x,
                                         pointOnTheMain.y + self.touchOffset.y);
        
        self.draggingView.center = correction;
    }
    
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    [self onTouchesEndedWithTouch:touch andEvent:event];
    
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    [self onTouchesEndedWithTouch:touch andEvent:event];
    
}

@end
