//
//  RTUser.h
//  VKAPITest
//
//  Created by Руслан on 11.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTServerObject.h"

@interface RTUser : RTServerObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL;

- (instancetype) initWithServerResponse:(NSDictionary *)response;

@end
