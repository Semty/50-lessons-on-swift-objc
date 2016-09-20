//
//  Doctor.m
//  DelegatesTest
//
//  Created by Руслан on 20.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Doctor.h"
#import "Patient.h"

@implementation Doctor

#pragma mark - PatientDelegate

- (void) patientFeelsBad:(Patient*)patient {
    
    NSLog(@"Patient %@ feels bad. His temperature is %f", patient.name, patient.temperature);
    
    if (patient.temperature >= 37.f && patient.temperature <= 39.f) {
        [patient takePill];
    } else if (patient.temperature > 39.f) {
        [patient makeShot];
    } else {
        NSLog(@"Patient %@ should rest", patient.name);
    }
    
}

- (void) patient:(Patient*)patient hasQuestion:(NSString*)question {
    
    NSLog(@"Patient %@ has a question: %@", patient.name, question);
    
}

@end
