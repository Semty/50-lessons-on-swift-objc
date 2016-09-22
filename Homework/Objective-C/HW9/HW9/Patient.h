//
//  Patient.h
//  HW9
//
//  Created by Руслан on 21.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PatientDelegate;

typedef enum {
    
    soreThroat,
    stomachache,
    headache
    
} Symptoms;

typedef enum {
    
    like,
    dislike
    
} Feedback;

@interface Patient : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) Float64 temperature;
@property (weak, nonatomic) id <PatientDelegate> delegate;
@property (assign, nonatomic) Symptoms symptom;
@property (assign, nonatomic) Feedback feedback;

- (BOOL) howAreYou;
- (void) takePill;
- (void) makeShot;
- (void) change:(id<PatientDelegate>)doctor from:(NSArray*)doctors;

@end


@protocol PatientDelegate <NSObject>

@property (strong, nonatomic) NSString* name;

- (void) patientFeelsBad:(Patient*)patient;

@end
