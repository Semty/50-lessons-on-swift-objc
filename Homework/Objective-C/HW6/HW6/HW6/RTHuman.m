//
//  RTHuman.m
//  HW6
//
//  Created by Руслан on 17.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTHuman.h"

@implementation RTHuman

- (NSString*) printSelf:(NSString*)name :(RTGender)gender :(RTDirection)direction {
    
    NSString* stringGender;
    NSString* stringDirection;
    
    switch (gender) {
        case 0:
            stringGender = @"male";
            break;
        case 1:
            stringGender = @"female";
            break;
        default:
            break;
    }
    
    switch (direction) {
        case 0:
            stringDirection = @"ahead";
            break;
        case 1:
            stringDirection = @"back";
            break;
        case 2:
            stringDirection = @"left";
            break;
        case 3:
            stringDirection = @"right";
            break;
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"My name is %@. I am a %@. I am moving %@",
            name, stringGender, stringDirection];
}

@end
