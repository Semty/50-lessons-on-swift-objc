//
//  Doctor.m
//  HW9
//
//  Created by Руслан on 21.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Doctor.h"
#import "Patient.h"

@implementation Doctor

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headacheCount = [[NSMutableArray alloc] init];
        self.stomachacheCount = [[NSMutableArray alloc] init];
        self.soreThroatCount = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Doctor

- (void) clearCount {
    [_stomachacheCount removeAllObjects];
    [_headacheCount removeAllObjects];
    [_soreThroatCount removeAllObjects];
}

- (void) report {
    
    NSLog(@"          ***   GOOD DOCTOR %@ REPORT ***", self.name);
    
    NSLog(@"Sore throat - %lu patient(s)", [self.soreThroatCount count]);
    NSInteger count = 0;
    for (NSString* name in _soreThroatCount) {
        count += 1;
        NSLog(@"%ld. %@", count, name);
    }
    NSLog(@"\n\n");
    count = 0;
    
    NSLog(@"Stomachache - %lu patient(s)", [self.stomachacheCount count]);
    for (NSString* name in _stomachacheCount) {
        count += 1;
        NSLog(@"%ld. %@", count, name);
    }
    NSLog(@"\n\n");
    count = 0;
    
    NSLog(@"Headache - %lu patient(s)", [self.headacheCount count]);
    for (NSString* name in _headacheCount) {
        count += 1;
        NSLog(@"%ld. %@", count, name);
    }
    NSLog(@"\n\n");
    count = 0;
}

#pragma mark - PatientDelegate

- (void) patientFeelsBad:(Patient *)patient {
    NSLog(@"Patient %@ feels bad :( . (Good doctor: %@)", patient.name, self.name);
    
    switch (patient.symptom) {
        case 0:
            [_soreThroatCount addObject:patient.name];
            NSLog(@"%@ has a sore throat", patient.name);
            NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
            
            if (patient.temperature >= 37.f && patient.temperature < 38.f) {
                [patient takePill];
            } else if (patient.temperature >= 38.f && patient.temperature < 41.f) {
                [patient makeShot];
            }
            break;
            
        case 1:
            [_stomachacheCount addObject:patient.name];
            NSLog(@"%@ has a stomachache", patient.name);
            NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
            
            if (patient.temperature <= 38.f) {
                NSLog(@"You should have a rest");
            } else if (patient.temperature > 38.f) {
                [patient makeShot];
            }
            break;
            
        case 2:
            [_headacheCount addObject:patient.name];
            NSLog(@"%@ has a headache", patient.name);
            NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
            
            [patient takePill];
            break;
    }
}

@end
