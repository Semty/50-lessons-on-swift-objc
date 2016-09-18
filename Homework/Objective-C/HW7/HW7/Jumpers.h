//
//  Jumpers.h
//  HW7
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Jumpers <NSObject>

@required
@property (strong, nonatomic) NSString* name;

- (NSString*) jump;

@optional
- (NSString*) laugh;

@end
