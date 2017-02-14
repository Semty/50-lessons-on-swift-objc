//
//  RTPost.m
//  VKAPITest
//
//  Created by Руслан on 14.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTPost.h"

@implementation RTPost

- (instancetype)initWithServerResponse:(NSDictionary *)response
{
    self = [super initWithServerResponse:response];
    if (self) {
        
        self.text = [response objectForKey:@"text"];
        
    }
    return self;
}

@end
