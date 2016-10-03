//
//  RTStudent.h
//  BitsTest
//
//  Created by Руслан on 03.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    RTStudentSubjectTypeBiology         = 1 << 0,
    RTStudentSubjectTypeMath            = 1 << 1,
    RTStudentSubjectTypeDevelopment     = 1 << 2,
    RTStudentSubjectTypeEngineering     = 1 << 3,
    RTStudentSubjectTypeArt             = 1 << 4,
    RTStudentSubjectTypePsychology      = 1 << 5,
    RTStudentSubjectTypeAnatomy         = 1 << 6
    
}RTStudentSubjectType;

@interface RTStudent : NSObject

@property (assign, nonatomic) RTStudentSubjectType subjectType;

/*
@property (assign, nonatomic) BOOL studiesBioligy;
@property (assign, nonatomic) BOOL studiesMath;
@property (assign, nonatomic) BOOL studiesDevelopment;
@property (assign, nonatomic) BOOL studiesEngineering;
@property (assign, nonatomic) BOOL studiesArt;
@property (assign, nonatomic) BOOL studiesPsychology;
@property (assign, nonatomic) BOOL studiesAnatomy;
*/

@end
