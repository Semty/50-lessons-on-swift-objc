//
//  RTPatientSuperman.m
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTPatientSuperman.h"

@implementation RTPatientSuperman

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.temperature = (arc4random() % 60) / 10 + 36.6f;
        
        self.doctorSuperman = ^(RTPatientSuperman *patient) {
            
            NSLog(@"Patient %@ feels bad :( .", patient.name);
            
            switch (patient.symptom) {
                case 0:
                    NSLog(@"%@ has a sore throat", patient.name);
                    NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
                    
                    if (patient.temperature >= 36.f && patient.temperature < 38.f) {
                        [patient takePill];
                    } else if (patient.temperature >= 38.f && patient.temperature < 41.f) {
                        [patient makeShot];
                    }
                    break;
                    
                case 1:
                    NSLog(@"%@ has a stomachache", patient.name);
                    NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
                    
                    if (patient.temperature <= 38.f) {
                        NSLog(@"You should have a rest\n\n");
                    } else if (patient.temperature > 38.f) {
                        [patient makeShot];
                    }
                    break;
                    
                case 2:
                    NSLog(@"%@ has a headache", patient.name);
                    NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
                    
                    [patient takePill];
                    break;
            }
        };


        [self performSelector:@selector(doctorsBlock:) withObject:self.doctorSuperman afterDelay:arc4random() % 11 + 5];
    }
    return self;
}


- (BOOL) howAreYou {
    BOOL isOk = arc4random() % 2;
    if (!isOk) {
        self.symptom = arc4random() % 3;
        return isOk;
    }
    NSLog(@"%@ is completely healthy\n\n", self.name);
    return isOk;
}

/*- (void) dealloc {
    NSLog(@"Patient %@ is deallocated\n\n", self.name);
}*/

#pragma mark - Methods

- (void) takePill {
    NSLog(@"%@ takes a pill :)\n\n", self.name);
}

- (void) makeShot {
    NSLog(@"%@ make a shot\n\n", self.name);
}

- (void) doctorsBlock:(void (^)(RTPatientSuperman *))doctor {
    if (![self howAreYou]) {
        doctor(self);
    }
}

@end
