//
//  Patient.m
//  HW9
//
//  Created by Руслан on 21.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.temperature = (arc4random() % 60) / 10 + 36.6f;
    }
    return self;
}

- (BOOL) howAreYou {
    
    BOOL isOk = arc4random() % 2;
    
    if (!isOk) {
        self.symptom = arc4random() % 3;
        [self.delegate patientFeelsBad:self];
        self.feedback = arc4random() % 2;
    } else {
        NSLog(@"%@ is completely healthy", self.name);
    }
    
    return isOk;
    
}

- (void) change:(id<PatientDelegate>)doctor from:(NSArray *)doctors {
    
    for (id<PatientDelegate> newDoctor in doctors) {
        if (newDoctor != doctor) {
            self.delegate = newDoctor;
            NSLog(@"Patient's %@ has a new doctor. He(She) is %@", self.name, newDoctor.name);
            break;
        }
    }
}

- (void) takePill {
    NSLog(@"%@ takes a pill :)", self.name);
}

- (void) makeShot {
    NSLog(@"%@ make a shot", self.name);
}

@end
