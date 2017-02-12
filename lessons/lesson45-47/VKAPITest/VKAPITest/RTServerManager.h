//
//  RTServerManager.h
//  VKAPITest
//
//  Created by Руслан on 11.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTUser;

@interface RTServerManager : NSObject

@property (strong, nonatomic, readonly) RTUser *currentUser;

+ (RTServerManager *) sharedManager;

- (void) authorizeUser:(void(^)(RTUser *user))completion;

- (void) getUser:(NSString *)userID
       onSuccess:(void(^)(RTUser *user))success
       onFailure:(void(^)(NSError *error, NSInteger statusCode))failure;

- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                    onSuccess:(void(^)(NSArray *friends))success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode))failure;

@end
