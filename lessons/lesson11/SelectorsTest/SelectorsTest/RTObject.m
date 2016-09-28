//
//  RTObject.m
//  SelectorsTest
//
//  Created by Руслан on 25.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTObject.h"

@implementation RTObject

- (void) testMethod {
    NSLog(@"\n\n\nRTObject testMethod\n\n\n");
}

- (NSString *) superSecretText {
    return @"\n\n\nI have stolen your candy\n\n\n";
}

@end
