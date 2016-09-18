//
//  Dancer.m
//  ProtocolsTest
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Dancer.h"

@implementation Dancer

- (void) dance {
    
}

#pragma mark - Patient

- (BOOL) areYouOk {
    
    BOOL ok = arc4random() % 2;
    
    NSLog(@"Is dancer %@ ok? %@", self.name, ok ? @"Yes" : @"No");
    
    return ok;
}

- (void) takePill {
    NSLog(@"Dancer %@ takes a pill", self.name);
}

- (void) makeShot {
    NSLog(@"Dancer %@ makes a shot", self.name);
}


@end
