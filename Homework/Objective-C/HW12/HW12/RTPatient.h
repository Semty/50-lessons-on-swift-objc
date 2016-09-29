//
//  RTPatient.h
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RTStudent;

typedef enum {
    
    soreThroat,
    stomachache,
    headache
    
} Symptoms;

@interface RTPatient : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) Float64 temperature;
@property (assign, nonatomic) Symptoms symptom;

- (BOOL) howAreYou;
- (void) takePill;
- (void) makeShot;
- (void) doctorsBlock:(void (^)(RTPatient *))doctor withPatient:(RTPatient *)patient;

@end
