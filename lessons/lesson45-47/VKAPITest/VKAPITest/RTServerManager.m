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

@interface RTServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

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

- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                    onSuccess:(void(^)(NSArray *friends))success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode))failure{
    
    NSDictionary *parameters = @{ @"user_id"    : @"177780397",
                                  @"order"      : @"name",
                                  @"count"      : @(count),
                                  @"offset"     : @(offset),
                                  @"fields"     : @"photo_100",
                                  @"name_case"  : @"nom",
                                  @"v"          : @"5.62" };
    
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

@end










