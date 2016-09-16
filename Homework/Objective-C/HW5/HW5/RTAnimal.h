//
//  RTAnimal.h
//  Lesson5
//
//  Created by Руслан on 16.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTAnimal : NSObject

@property (strong, nonatomic) NSString* species;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) int age;

- (void) movement;

@end
