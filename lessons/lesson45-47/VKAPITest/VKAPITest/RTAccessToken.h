//
//  RTAccessToken.h
//  VKAPITest
//
//  Created by Руслан on 12.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTAccessToken : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSDate *expiresDate;
@property (strong, nonatomic) NSString *userID;

@end
