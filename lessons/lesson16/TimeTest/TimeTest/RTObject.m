//
//  RTObject.m
//  TimeTest
//
//  Created by Руслан on 05.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTObject.h"

@interface RTObject ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation RTObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"\n\nRTObject is initialized!\n");
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timertest:) userInfo:nil repeats:YES];
        
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        
        //self.timer = timer;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"\n\nRTObject is deallocated!\n");
}

- (void) timertest:(NSTimer *)timer {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH:mm:ss:SS"];
    NSLog(@"\n\n\n%@\n", [dateFormatter stringFromDate:[NSDate date]]);
    
}

@end
