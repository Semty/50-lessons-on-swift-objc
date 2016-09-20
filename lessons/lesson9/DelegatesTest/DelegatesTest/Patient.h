//
//  Patient.h
//  DelegatesTest
//
//  Created by Руслан on 20.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PatientDelegate;

@interface Patient : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) Float64 temperature;
@property (weak, nonatomic) id <PatientDelegate> delegate;

- (BOOL) howAreYou;
- (void) takePill;
- (void) makeShot;

@end


@protocol PatientDelegate <NSObject>

- (void) patientFeelsBad:(Patient*)patient;
- (void) patient:(Patient*)patient hasQuestion:(NSString*)question;

@end