//
//  RTHuman.h
//  HW6
//
//  Created by Руслан on 17.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    Male,
    Female
    
} RTGender;

typedef enum {
    
    Ahead,
    Back,
    Left,
    Right
    
} RTDirection;

@interface RTHuman : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) RTGender gender;
@property (assign, nonatomic) RTDirection direction;

- (NSString*) printSelf:(NSString*)name :(RTGender)gender :(RTDirection)direction;

@end
