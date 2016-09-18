//
//  Developer.m
//  ProtocolsTest
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Developer.h"

@implementation Developer

- (void) work {
    
}


#pragma mark - Patient

- (BOOL) areYouOk {
    
    BOOL ok = arc4random() % 2;
    
    NSLog(@"Is developer %@ ok? %@", self.name, ok ? @"Yes" : @"No");
    
    return ok;
}

- (void) takePill {
    NSLog(@"Developer %@ takes a pill", self.name);
}

- (void) makeShot {
    NSLog(@"Developer %@ makes a shot", self.name);
}

- (NSString*) howIsYourJob {
    return @"My job is awesome! I like it!";
}

@end
