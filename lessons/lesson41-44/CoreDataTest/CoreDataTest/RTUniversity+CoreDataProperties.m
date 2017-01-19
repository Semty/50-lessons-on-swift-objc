//
//  RTUniversity+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTUniversity+CoreDataProperties.h"

@implementation RTUniversity (CoreDataProperties)

+ (NSFetchRequest<RTUniversity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTUniversity"];
}

@dynamic name;
@dynamic courses;
@dynamic students;

@end
