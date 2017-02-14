//
//  RTServerManager.m
//  VKAPITest
//
//  Created by Руслан on 11.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTServerManager.h"
#import <AFNetworking.h>
#import "RTUser.h"
#import "RTPost.h"
#import "RTLoginViewController.h"
#import "RTAccessToken.h"

@interface RTServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) RTAccessToken *accessToken;

@end

@implementation RTServerManager

+ (RTServerManager *) sharedManager {
    
    static RTServerManager *serverManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serverManager = [[RTServerManager alloc] init];
    });
    
    return serverManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        
    }
    return self;
}

- (void) authorizeUser:(void(^)(RTUser *user))completion {
    
    RTLoginViewController *vc =
    [[RTLoginViewController alloc] initWithComplitionBlock:^(RTAccessToken *accessToken) {
        
        self.accessToken = accessToken;
        
        if (accessToken) {
            
            [self getUser:self.accessToken.userID
             
                onSuccess:^(RTUser *user) {
                    
                    if (completion) {
                        completion(user);
                    }
                    
                } onFailure:^(NSError *error, NSInteger statusCode) {
                    
                    if (completion) {
                        completion(nil);
                    }
                }];
            
        } else if (completion) {
            completion(nil);
        }
        
    }];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIViewController *mainVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [mainVC presentViewController:nav animated:YES completion:nil];
}

- (void) getUser:(NSString *)userID
       onSuccess:(void(^)(RTUser *user))success
       onFailure:(void(^)(NSError *error, NSInteger statusCode))failure {
    
    NSDictionary *parameters = @{ @"user_ids"       : userID,
                                  @"fields"         : @"photo_100",
                                  @"name_case"      : @"nom",
                                  @"lang"           : @"ru",
                                  @"https"          : @1,
                                  @"access_token"   : self.accessToken.accessToken,
                                  @"v"              : @5.62 };
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                          URLString:@"https://api.vk.com/method/users.get"
                                                                         parameters:parameters
                                                                              error:nil];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request
                                                     completionHandler:^(NSURLResponse *response,
                                                                         NSDictionary *responseObject,
                                                                         NSError *error) {
                                                         if (error) {
                                                             NSLog(@"Error: %@", error);
                                                             
                                                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                             
                                                             if (failure) {
                                                                 failure(error, httpResponse.statusCode);
                                                             }
                                                             
                                                         } else {
                                                             NSLog(@"%@ %@", response, responseObject);
                                                             
                                                             RTUser *user = [[RTUser alloc]
                                                                             initWithServerResponse:
                                                                             [[responseObject objectForKey:@"response"] firstObject]];
                                                             
                                                             if (success) {
                                                                 success(user);
                                                             }
                                                         }
                                                     }];
    
    [dataTask resume];
    
}

- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                    onSuccess:(void(^)(NSArray *friends))success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode))failure {
    
    NSDictionary *parameters = @{ @"user_id"        : self.accessToken.userID,
                                  @"order"          : @"name",
                                  @"count"          : @(count),
                                  @"offset"         : @(offset),
                                  @"fields"         : @"photo_100",
                                  @"name_case"      : @"nom",
                                  @"lang"           : @"ru",
                                  @"https"          : @1,
                                  @"access_token"   : self.accessToken.accessToken,
                                  @"v"              : @5.62 };
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                          URLString:@"https://api.vk.com/method/friends.get"
                                                                         parameters:parameters
                                                                              error:nil];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request
                                                     completionHandler:^(NSURLResponse *response,
                                                                         NSDictionary *responseObject,
                                                                         NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if (failure) {
                failure(error, httpResponse.statusCode);
            }
            
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            NSArray *itemsArray = [[responseObject objectForKey:@"response"] objectForKey:@"items"];
            NSMutableArray *friendsArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *item in itemsArray) {
                RTUser *user = [[RTUser alloc] initWithServerResponse:item];
                [friendsArray addObject:user];
            }
            
            if (success) {
                success(friendsArray);
            }
        }
    }];
    
    [dataTask resume];
}

- (void) getGroupWall:(NSString *)groupDomain
           withOffset:(NSInteger)offset
                count:(NSInteger)count
            onSuccess:(void(^)(NSArray *posts))success
            onFailure:(void(^)(NSError *error, NSInteger statusCode))failure {
    
    NSDictionary *parameters = @{ @"domain"         : groupDomain,
                                  @"count"          : @(count),
                                  @"offset"         : @(offset),
                                  @"filter"         : @"all",
                                  @"extended"       : @1,
                                  @"fields"         : @"photo_100",
                                  @"lang"           : @"ru",
                                  @"https"          : @1,
                                  @"access_token"   : self.accessToken.accessToken,
                                  @"v"              : @5.62 };
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                          URLString:@"https://api.vk.com/method/wall.get"
                                                                         parameters:parameters
                                                                              error:nil];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request
                                                     completionHandler:^(NSURLResponse *response,
                                                                         NSDictionary *responseObject,
                                                                         NSError *error) {
                                                         if (error) {
                                                             NSLog(@"Error: %@", error);
                                                             
                                                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                             
                                                             if (failure) {
                                                                 failure(error, httpResponse.statusCode);
                                                             }
                                                             
                                                         } else {
                                                             NSLog(@"%@ %@", response, responseObject);
                                                             
                                                             NSArray *itemsArray = [[responseObject objectForKey:@"response"] objectForKey:@"items"];
                                                             NSMutableArray *postsArray = [[NSMutableArray alloc] init];
                                                             
                                                             for (NSDictionary *item in itemsArray) {
                                                                 RTPost *post = [[RTPost alloc] initWithServerResponse:item];
                                                                 [postsArray addObject:post];
                                                             }
                                                             
                                                             if (success) {
                                                                 success(postsArray);
                                                             }
                                                         }
                                                     }];
    
    [dataTask resume];
}

- (void) postText:(NSString *)text
      onGroupWall:(NSString *)groupID
        onSuccess:(void(^)(NSDictionary *result))success
        onFailure:(void(^)(NSError *error, NSInteger statusCode))failure{
    
    NSDictionary *parameters = @{ @"owner_id"       : groupID,
                                  @"message"        : text,
                                  @"https"          : @1,
                                  @"access_token"   : self.accessToken.accessToken,
                                  @"v"              : @5.62 };
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                          URLString:@"https://api.vk.com/method/wall.post"
                                                                         parameters:parameters
                                                                              error:nil];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request
                                                     completionHandler:^(NSURLResponse *response,
                                                                         NSDictionary *responseObject,
                                                                         NSError *error) {
                                                         if (error) {
                                                             NSLog(@"Error: %@", error);
                                                             
                                                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                             
                                                             if (failure) {
                                                                 failure(error, httpResponse.statusCode);
                                                             }
                                                             
                                                         } else {
                                                             NSLog(@"%@ %@", response, responseObject);
                                                             
                                                             if (success) {
                                                                 success(responseObject);
                                                             }
                                                         }
                                                     }];
    
    [dataTask resume];
    
}

@end










