//
//  RTPatient.m
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTPatient.h"

@implementation RTPatient

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.temperature = (arc4random() % 60) / 10 + 36.6f;
    }
    return self;
}

/*- (void) dealloc {
    NSLog(@"Patient %@ is deallocated\n\n", self.name);
}*/

#pragma mark - Methods

- (BOOL) howAreYou {
    
    BOOL isOk = arc4random() % 2;
    
    if (isOk) {
        NSLog(@"%@ is completely healthy\n\n", self.name);
    } else {
        self.symptom = arc4random() % 3;
        return isOk;
    }
    
    return isOk;
}

- (void) takePill {
    NSLog(@"%@ takes a pill :)\n\n", self.name);
}

- (void) makeShot {
    NSLog(@"%@ make a shot\n\n", self.name);
}

- (void) doctorsBlock:(void (^)(RTPatient *))doctor withPatient:(RTPatient *)patient {
    if (![self howAreYou]) {
        doctor(patient);
    }
}

@end
