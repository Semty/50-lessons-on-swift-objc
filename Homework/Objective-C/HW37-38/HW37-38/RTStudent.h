//
//  RTStudent.h
//  HW37-38
//
//  Created by Руслан on 08.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
  
    RTMan,
    RTWoman
    
} RTGender;

@interface RTStudent : NSObject <MKAnnotation>

@property (assign, nonatomic) BOOL meetingState;
@property (strong, nonatomic) NSString *meetingDistance;

@property (assign, nonatomic) RTGender gender;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@property (strong, nonatomic) NSString *birthday;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;

@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double latitude;

@end
