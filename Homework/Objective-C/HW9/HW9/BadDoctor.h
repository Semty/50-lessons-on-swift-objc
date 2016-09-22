//
//  BadDoctor.h
//  HW9
//
//  Created by Руслан on 22.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface BadDoctor : NSObject <PatientDelegate>

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSMutableArray* headacheCount;
@property (strong, nonatomic) NSMutableArray* stomachacheCount;
@property (strong, nonatomic) NSMutableArray* soreThroatCount;

- (void) tellTheFairyTaleFor:(Patient*)patient;
- (void) runAway;
- (void) request;
- (void) report;
- (void) clearCount;

@end
