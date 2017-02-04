//
//  RTCourse+CoreDataProperties.m
//  HW41
//
//  Created by Руслан on 28.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCourse+CoreDataProperties.h"

@implementation RTCourse (CoreDataProperties)

+ (NSFetchRequest<RTCourse *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTCourse"];
}

@dynamic name;
@dynamic subject;
@dynamic studyBranch;
@dynamic students;
@dynamic teacher;

@end
