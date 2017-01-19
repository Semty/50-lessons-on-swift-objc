//
//  RTStudent.m
//  KVCTest
//
//  Created by Руслан on 04.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent.h"

@implementation RTStudent

#pragma mark - Setters

- (void) setName:(NSString *)name {
    
    _name = name;
    
    NSLog(@"setName = %@", name);
}

- (void) setAge:(NSInteger)age {
    
    _age = age;
    
    NSLog(@"setAge = %ld", age);
}

#pragma mark - Override description

- (NSString *) description {
    return [NSString stringWithFormat:@"Student: %@ %ld", self.name, self.age];
}

#pragma mark - Override undefined keys

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"!!! setValueForUndefinedKey = %@ !!!", key);
}

- (instancetype) valueForUndefinedKey:(NSString *)key {
    NSLog(@"!!! valueForUndefinedKey = %@ !!!", key);
    return nil;
}

#pragma mark - Functions

- (void) changeName {
    
    [self willChangeValueForKey:@"name"];
    _name = @"FakeName";
    [self didChangeValueForKey:@"name"];
}

#pragma mark - Validation

/*
- (BOOL)validateValue:(inout id _Nullable * _Nonnull)ioValue forKey:(NSString *)inKey error:(out NSError **)outError {
    
    if ([inKey isEqualToString:@"name"]) {
        
        NSString *newName = *ioValue;
        
        if (![newName isKindOfClass:[NSString class]]) {
            *outError = [[NSError alloc] initWithDomain:@"Not NSString" code:1 userInfo:nil];
            return NO;
        }
        
        if ([newName rangeOfString:@"1"].location != NSNotFound) {
            *outError = [[NSError alloc] initWithDomain:@"Has numbers" code:2 userInfo:nil];
            return NO;
        }
        
    }
    
    return YES;
}
*/

/*
- (BOOL) validateName:(inout id _Nullable * _Nonnull)ioValue error:(out NSError **)outError {
    
    NSLog(@"AAAAAAAAAA");
    
    return YES;
}
*/

@end












