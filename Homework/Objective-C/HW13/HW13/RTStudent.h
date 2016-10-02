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

+ (NSOperationQueue *) sharedOperationQueue;

+ (dispatch_queue_t) sharedQueue;

- (instancetype) initWithName:(NSString *)name;

- (void) guessTheAnswer1:(NSInteger)answer withMaxNumber:(NSInteger)maxNumber andResultBlock:(void(^)(NSString *, double))resultBlock;

- (void) guessTheAnswer2:(NSInteger)answer withMaxNumber:(NSInteger)maxNumber andResultBlock:(void(^)(NSString *, double))resultBlock;

@end
