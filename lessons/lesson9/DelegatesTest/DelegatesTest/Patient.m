//
//  Patient.m
//  DelegatesTest
//
//  Created by Руслан on 20.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (BOOL) howAreYou {
    
    BOOL iFeelGood = arc4random() % 2;
    
    if (!iFeelGood) {
        [self.delegate patientFeelsBad:self];
    }
    
    return iFeelGood;
}

- (void) takePill {
    NSLog(@"%@ takes a pill", self.name);
}

- (void) makeShot {
    NSLog(@"%@ make a shot", self.name);
}


@end
