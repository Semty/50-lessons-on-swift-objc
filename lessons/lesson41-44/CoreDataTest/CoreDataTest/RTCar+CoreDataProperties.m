//
//  RTCar+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCar+CoreDataProperties.h"

@implementation RTCar (CoreDataProperties)

+ (NSFetchRequest<RTCar *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTCar"];
}

@dynamic model;
@dynamic owner;

@end
