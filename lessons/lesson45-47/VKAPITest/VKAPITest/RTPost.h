//
//  RTPost.h
//  VKAPITest
//
//  Created by Руслан on 14.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTServerObject.h"

@interface RTPost : RTServerObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSURL *authorImageURL;

- (instancetype) initWithServerResponse:(NSDictionary *)response;

@end
