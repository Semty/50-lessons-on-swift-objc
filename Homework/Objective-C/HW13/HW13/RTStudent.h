//
//  RTStudent.h
//  HW13
//
//  Created by Руслан on 01.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTStudent : NSObject

@property (strong, nonatomic) NSString *name;

- (instancetype) initWithName:(NSString *)name;

- (void) guessTheAnswer:(NSInteger)answer withMaxNumber:(NSInteger)maxNumber
               andQueue:(dispatch_queue_t)studentQueue withResultBlock:(void(^)(NSString *, double))resultBlock;

@end
