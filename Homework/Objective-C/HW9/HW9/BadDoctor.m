//
//  BadDoctor.m
//  HW9
//
//  Created by Руслан on 22.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "BadDoctor.h"

@implementation BadDoctor

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

#pragma mark - BadDoctor

- (void) clearCount {
    [_stomachacheCount removeAllObjects];
    [_headacheCount removeAllObjects];
    [_soreThroatCount removeAllObjects];
}

- (void) report {
    
    NSLog(@"          ***   BAD DOCTOR %@ REPORT ***", self.name);
    
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

- (void) tellTheFairyTaleFor:(Patient*)patient {
    NSLog(@"Bad doctor %@ tells the fairy tale. Patient %@ feels worse", self.name, patient.name);
}

- (void) runAway {
    NSLog(@"Bad doctor %@ runs away!", self.name);
}

- (void) request {
    NSLog(@"Can you tell the people that I make you healthy, please?))");
}

#pragma mark - PatientDelegate

- (void) patientFeelsBad:(Patient *)patient {
    NSLog(@"Patient %@ feels bad :( . (Bad doctor: %@)", patient.name, self.name);
    
    switch (patient.symptom) {
        case 0:
            [_soreThroatCount addObject:patient.name];
            NSLog(@"%@ has a sore throat", patient.name);
            NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
            
            if (patient.temperature >= 37.f && patient.temperature < 38.f) {
                [self tellTheFairyTaleFor:patient];
            } else if (patient.temperature >= 38.f && patient.temperature < 41.f) {
                [self runAway];
            }
            break;
            
        case 1:
            [_stomachacheCount addObject:patient.name];
            NSLog(@"%@ has a stomachache", patient.name);
            NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
            
            if (patient.temperature <= 38.f) {
                [self request];
                NSLog(@"Patient %@ feels worse", patient.name);
            } else if (patient.temperature > 38.f) {
                [self tellTheFairyTaleFor:patient];
            }
            break;
            
        case 2:
            [_headacheCount addObject:patient.name];
            NSLog(@"%@ has a headache", patient.name);
            NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
            
            [self tellTheFairyTaleFor:patient];
            break;
    }
}

@end
