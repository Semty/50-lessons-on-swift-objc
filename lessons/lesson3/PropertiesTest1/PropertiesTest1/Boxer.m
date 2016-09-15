//
//  Boxer.m
//  PropertiesTest1
//
//  Created by Руслан on 14.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Boxer.h"

@interface Boxer ()
@property (assign, nonatomic) int nameCount;
@end

@implementation Boxer
@synthesize name = _name;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nameCount = 0;
        self.name = @"DefaultName";
        self.surname = @"DefaultSurname";
        self.age = 0;
        self.height = 0.6f;
        self.weight = 4.52f;
    }
    return self;
}

- (void) setName:(NSString *)name {
    NSLog(@"Setter of the name was called");
    _name = name;
}

- (NSString*) name:(NSString*)name surname:(NSString*)surname {
    name = [name stringByAppendingString:@" "];
    NSString* fullname = [name stringByAppendingString:surname];
    return fullname;
}

- (NSString*) name {
    self.nameCount += 1;
    NSLog(@"Name was called %d times", self.nameCount);
    return _name;
}

- (int) age {
    NSLog(@"Getter of the age was called");
    return _age;
}

- (int) howOldAreYou {
    return self.age;
}

@end
