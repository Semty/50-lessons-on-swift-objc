//
//  RTStudent.m
//  HW13
//
//  Created by Руслан on 01.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent.h"
#import <UIKit/UIKit.h>

@implementation RTStudent

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

+ (NSOperationQueue *) sharedOperationQueue {
    
    static NSOperationQueue *studentQueue;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        studentQueue = [[NSOperationQueue alloc] init];
    });
    
    return studentQueue;
}

+ (dispatch_queue_t) sharedQueue {
    
    static dispatch_queue_t studentQueue;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        studentQueue = dispatch_queue_create("com.rstimchenko.HW13.studentQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return studentQueue;
}

- (void) guessTheAnswer1:(NSInteger)answer withMaxNumber:(NSInteger)maxNumber andResultBlock:(void (^)(NSString *, double))resultBlock {
    
    dispatch_queue_t studentQueue = [RTStudent sharedQueue];
    
    dispatch_async(studentQueue, ^{
    
        __weak RTStudent *weakSelf = self;
    
        NSInteger tempAnswer = maxNumber;
        NSInteger count = -1;
        
        double startTime = CACurrentMediaTime();
        while (tempAnswer != answer) {
            tempAnswer = arc4random() % maxNumber;
            count += 1;
        }
        
        resultBlock(weakSelf.name, CACurrentMediaTime() - startTime);
        
    });
}

- (void) guessTheAnswer2:(NSInteger)answer withMaxNumber:(NSInteger)maxNumber andResultBlock:(void (^)(NSString *, double))resultBlock {
    
    NSOperationQueue *studentQueue = [RTStudent sharedOperationQueue];
    
    [studentQueue addOperationWithBlock:^{
        
        __weak RTStudent *weakSelf = self;
        
        NSInteger tempAnswer = maxNumber;
        NSInteger count = -1;
        
        double startTime = CACurrentMediaTime();
        while (tempAnswer != answer) {
            tempAnswer = arc4random() % maxNumber;
            count += 1;
        }
        resultBlock(weakSelf.name, CACurrentMediaTime() - startTime);
    }];
}

@end
