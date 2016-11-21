//
//  NSString+Random.h
//  SearchTest
//
//  Created by Руслан on 21.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Random)

+ (NSString *)randomAlphanumericString;
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;

@end
