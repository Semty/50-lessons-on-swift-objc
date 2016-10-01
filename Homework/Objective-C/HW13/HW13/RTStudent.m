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



- (void) guessTheAnswer:(NSInteger)answer withMaxNumber:(NSInteger)maxNumber andQueue:(dispatch_queue_t)studentQueue
        withResultBlock:(void (^)(NSString *, double))resultBlock {
    
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

@end
