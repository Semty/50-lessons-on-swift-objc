//
//  Boxer.h
//  PropertiesTest1
//
//  Created by Руслан on 14.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Boxer : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) int age;
@property (assign, nonatomic) float height;
@property (assign, nonatomic) float weight;
@property (strong, nonatomic) NSString* surname;

- (int) howOldAreYou;
- (NSString*) name:(NSString*)name surname:(NSString*)surname;

@end
