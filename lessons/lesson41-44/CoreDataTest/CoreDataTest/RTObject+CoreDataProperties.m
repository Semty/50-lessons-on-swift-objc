//
//  RTObject+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTObject+CoreDataProperties.h"

@implementation RTObject (CoreDataProperties)

+ (NSFetchRequest<RTObject *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTObject"];
}


@end
