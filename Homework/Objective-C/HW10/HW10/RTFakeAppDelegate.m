//
//  RTFakeAppDelegate.m
//  HW10
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTFakeAppDelegate.h"
#import "AppDelegate.h"

@implementation RTFakeAppDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(DidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(WillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(DidFinishLaunchingNotification:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(WillResignActiveNotification:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(DidBecomeActiveNotification:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(WillTerminateNotification:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];

    }
    return self;
}

#pragma mark - Notifications

- (void) DidEnterBackgroundNotification:(NSNotification *)notification {
    NSLog(@"FAKE appDelegate DidEnterBackgroundNotification\n\n");
}

- (void) WillEnterForegroundNotification:(NSNotification *)notification {
    NSLog(@"FAKE appDelegate WillEnterForegroundNotification\n\n");
}

- (void) DidFinishLaunchingNotification:(NSNotification *)notification {
    NSLog(@"FAKE appDelegate DidFinishLaunchingNotification\n\n");
}

- (void) WillResignActiveNotification:(NSNotification *)notification {
    NSLog(@"FAKE appDelegate WillResignActiveNotification\n\n");
}

- (void) DidBecomeActiveNotification:(NSNotification *)notification {
    NSLog(@"FAKE appDelegate DidBecomeActiveNotification\n\n");
}

- (void) WillTerminateNotification:(NSNotification *)notification {
    NSLog(@"FAKE appDelegate WillTerminateNotification\n\n");
}

@end
