//
//  RTServerManager.h
//  VKAPITest
//
//  Created by Руслан on 11.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTServerManager : NSObject

+ (RTServerManager *) sharedManager;

- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                    onSuccess:(void(^)(NSArray *friends))success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode))failure;

@end
