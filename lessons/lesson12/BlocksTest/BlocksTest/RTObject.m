//
//  RTObject.m
//  BlocksTest
//
//  Created by Руслан on 28.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTObject.h"

@interface RTObject ()

@property (copy, nonatomic) ObjectBlock objectBlock;

@end

@implementation RTObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak NSString *weakSelfName = self.name;
        self.objectBlock = ^{
            NSLog(@"%@", weakSelfName);
        };
    }
    return self;
}

- (void) testMethod:(ObjectBlock)someBlock {
    someBlock();
}

- (void) dealloc {
    NSLog(@"\n\nRTObject %@ is deallocated!\n\n", self.name);
}

@end
