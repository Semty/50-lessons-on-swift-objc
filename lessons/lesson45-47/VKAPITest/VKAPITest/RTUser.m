//
//  RTUser.m
//  VKAPITest
//
//  Created by Руслан on 11.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTUser.h"

@implementation RTUser

- (instancetype)initWithServerResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        
        self.firstName = [response objectForKey:@"first_name"];
        self.lastName = [response objectForKey:@"last_name"];
        self.imageURL = [NSURL URLWithString:[response objectForKey:@"photo_100"]];
        
    }
    return self;
}

@end
