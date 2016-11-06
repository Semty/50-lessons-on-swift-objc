//
//  RTRandomColor.h
//  HW30
//
//  Created by Руслан on 05.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RTRandomColor : NSObject

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *name;

- (instancetype) initWithColorAndName;

@end
