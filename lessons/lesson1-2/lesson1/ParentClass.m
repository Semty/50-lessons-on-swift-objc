//
//  ParentClass.m
//  lesson1
//
//  Created by Руслан on 13.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ParentClass.h"

@implementation ParentClass

- (void) sayHello {
    NSLog(@"Parent says hello!");
}

- (void) say:(NSString*)someString {
    NSLog(@"%@", someString);
}

- (void) say:(NSString*)someString and:(NSString*)anotherString {
    NSLog(@"%@, %@", someString, anotherString);
}

- (NSString*) saySomething {
    return @"It is some return's value. Hhhhh...";
}

@end
