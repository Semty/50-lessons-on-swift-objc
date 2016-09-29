//
//  RTPatientSuperman.h
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTPatient.h"
@class RTPatientSuperman;

typedef  void (^DoctorSuperman)(RTPatientSuperman *);

@interface RTPatientSuperman : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) Float64 temperature;
@property (assign, nonatomic) Symptoms symptom;
@property (strong, nonatomic) DoctorSuperman doctorSuperman;

- (BOOL) howAreYou;
- (void) takePill;
- (void) makeShot;
- (void) doctorsBlock:(void (^)(RTPatientSuperman *))doctor;

@end
