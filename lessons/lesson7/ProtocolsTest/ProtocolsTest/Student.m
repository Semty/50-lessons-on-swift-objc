//
//  Student.m
//  ProtocolsTest
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Student.h"

@implementation Student

-(void) study {
    
}

#pragma mark - Patient

- (BOOL) areYouOk {
    
    BOOL ok = arc4random() % 2;
    
    NSLog(@"Is student %@ ok? %@", self.name, ok ? @"Yes" : @"No");
    
    return ok;
}

- (void) takePill {
    NSLog(@"Student %@ takes a pill", self.name);
}

- (void) makeShot {
    NSLog(@"Student %@ makes a shot", self.name);
}

- (NSString*) howIsYourFamily {
    return @"My family is doing something.";
}


@end
