//
//  Swimmer.m
//  HW7
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Swimmer.h"

@implementation Swimmer

- (NSString*) swim {
    return [NSString stringWithFormat:@"Swimmer %@ is swimming", self.name];
}

- (NSString*) laugh {
    return [NSString stringWithFormat:@"Swimmer %@ is laughing", self.name];
}

@end
