//
//  RTStudent+CoreDataProperties.m
//  HW41
//
//  Created by Руслан on 28.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent+CoreDataProperties.h"

@implementation RTStudent (CoreDataProperties)

+ (NSFetchRequest<RTStudent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTStudent"];
}

@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic learningCourses;
@dynamic teachingCourses;

@end
