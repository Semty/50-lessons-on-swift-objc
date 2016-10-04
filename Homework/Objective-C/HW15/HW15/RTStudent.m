//
//  RTStudent.m
//  HW15
//
//  Created by Руслан on 04.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent.h"

@implementation RTStudent

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void) setRandomSubjects {
    
    for (int i = 0; i <= 6; i++) {
        
        BOOL isSubject = arc4random() % 2;
        
        if (isSubject) {
            self.subjectType |= 1 << i;
        }
    }
}

- (NSString *) answerByType:(RTStudentSubjectType)type {
    return self.subjectType & type ? @"Yes" : @"No";
}

- (NSString *) description {
    
    return [NSString stringWithFormat:@"\n%@ studies:\n"
            "bioligy: %@\n"
            "development: %@\n"
            "engineering: %@\n"
            "art: %@\n"
            "psychology: %@\n"
            "anatomy: %@\n",
            self.name,
            [self answerByType:RTStudentSubjectTypeBiology],
            [self answerByType:RTStudentSubjectTypeDevelopment],
            [self answerByType:RTStudentSubjectTypeEngineering],
            [self answerByType:RTStudentSubjectTypeArt],
            [self answerByType:RTStudentSubjectTypePsychology],
            [self answerByType:RTStudentSubjectTypeAnatomy]];
    
}

@end
