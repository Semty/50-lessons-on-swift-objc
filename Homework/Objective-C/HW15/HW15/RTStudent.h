//
//  RTStudent.h
//  HW15
//
//  Created by Руслан on 04.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    RTStudentSubjectTypeAnatomy         = 1 << 0,
    RTStudentSubjectTypeArt             = 1 << 1,
    RTStudentSubjectTypeMath            = 1 << 2,
    RTStudentSubjectTypeEngineering     = 1 << 3,
    RTStudentSubjectTypeDevelopment     = 1 << 4,
    RTStudentSubjectTypeBiology         = 1 << 5,
    RTStudentSubjectTypePsychology      = 1 << 6
    
} RTStudentSubjectType;

@interface RTStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) RTStudentSubjectType subjectType;

- (void) setRandomSubjects;
- (instancetype) initWithName:(NSString *)name;

@end
