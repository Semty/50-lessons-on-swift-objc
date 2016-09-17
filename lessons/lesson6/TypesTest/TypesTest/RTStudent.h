//
//  RTStudent.h
//  TypesTest
//
//  Created by Руслан on 17.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    Male,
    Female
    
} RTGender;

@interface RTStudent : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) RTGender gender;

@end
