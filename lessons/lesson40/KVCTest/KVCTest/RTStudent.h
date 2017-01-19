//
//  RTStudent.h
//  KVCTest
//
//  Created by Руслан on 04.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

- (void) changeName;

@end
