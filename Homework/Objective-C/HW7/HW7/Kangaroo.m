//
//  Kangaroo.m
//  HW7
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Kangaroo.h"

@implementation Kangaroo

- (NSString*) run {
    return [NSString stringWithFormat:@"Kangaroo %@ is running", self.name];
}

- (NSString*) jump {
    return [NSString stringWithFormat:@"Kangaroo %@ is jumping", self.name];

}

@end
