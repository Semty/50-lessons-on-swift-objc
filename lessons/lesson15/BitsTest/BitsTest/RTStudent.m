//
//  RTStudent.m
//  BitsTest
//
//  Created by Руслан on 03.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent.h"

@implementation RTStudent

- (NSString *) answerByType:(RTStudentSubjectType)type {
    return self.subjectType & type ? @"Yes" : @"No";
}

- (NSString *) description {
    
    return [NSString stringWithFormat:@"\n\n\nStudent studies:\n\n"
                                       "bioligy: %@\n"
                                       "development: %@\n"
                                       "engineering: %@\n"
                                       "art: %@\n"
                                       "psychology: %@\n"
                                       "anatomy: %@\n\n",
                                        [self answerByType:RTStudentSubjectTypeBiology],
                                        [self answerByType:RTStudentSubjectTypeDevelopment],
                                        [self answerByType:RTStudentSubjectTypeEngineering],
                                        [self answerByType:RTStudentSubjectTypeArt],
                                        [self answerByType:RTStudentSubjectTypePsychology],
                                        [self answerByType:RTStudentSubjectTypeAnatomy]];
    
}

@end
