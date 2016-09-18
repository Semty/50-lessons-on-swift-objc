//
//  Runner.m
//  HW7
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Runner.h"

@implementation Runner

- (NSString*) run {
    return [NSString stringWithFormat:@"Runner %@ is running", self.name];
}

- (NSString*) laugh {
    return [NSString stringWithFormat:@"Runner %@ is laughing", self.name];
}

@end
