//
//  UIView+UITableViewCell.m
//  FileManagerStoryboardTest
//
//  Created by Руслан on 14.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell *) superCell {
    
    if (!self.superview) {
        return nil;
    }
    
    if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell *)self.superview;
    }
    return [self.superview superCell];
}

@end
