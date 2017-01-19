//
//  RTCourse+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCourse+CoreDataProperties.h"

@implementation RTCourse (CoreDataProperties)

+ (NSFetchRequest<RTCourse *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTCourse"];
}

@dynamic name;
@dynamic students;
@dynamic university;
@dynamic studentsWithManyCourses;
@dynamic bestStudents;

@end
