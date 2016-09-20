//
//  Student.h
//  HW8
//
//  Created by Руслан on 20.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* surname;

- (Student*) initWithName:(NSString*)name andSurname:(NSString*)surname;
- (NSString*) sayHello;

@end
