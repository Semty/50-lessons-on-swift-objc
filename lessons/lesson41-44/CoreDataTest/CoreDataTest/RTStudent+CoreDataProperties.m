//
//  RTStudent+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent+CoreDataProperties.h"

@implementation RTStudent (CoreDataProperties)

+ (NSFetchRequest<RTStudent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTStudent"];
}

@dynamic dateOfBirth;
@dynamic firstName;
@dynamic lastName;
@dynamic score;
@dynamic car;
@dynamic courses;
@dynamic university;

@end
