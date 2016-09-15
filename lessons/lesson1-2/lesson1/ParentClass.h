//
//  ParentClass.h
//  lesson1
//
//  Created by Руслан on 13.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParentClass : NSObject

- (void) sayHello;

- (void) say:(NSString*) someString;

- (void) say:(NSString*) someString and:(NSString*) anotherString;

- (NSString*) saySomething;

@end
