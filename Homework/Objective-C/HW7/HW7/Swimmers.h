//
//  Swimmers.h
//  HW7
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Swimmers <NSObject>

@required
@property (strong, nonatomic) NSString* name;

- (NSString*) swim;

@optional
- (NSString*) laugh;

@end
