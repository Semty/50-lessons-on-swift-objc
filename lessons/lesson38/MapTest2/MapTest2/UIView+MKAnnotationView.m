//
//  UIView+MKAnnotationView.m
//  MapTest2
//
//  Created by Руслан on 05.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MapKit.h>

@implementation UIView (MKAnnotationView)

- (MKAnnotationView *) superAnnotationView {
    
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView *)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotationView];
}

@end
