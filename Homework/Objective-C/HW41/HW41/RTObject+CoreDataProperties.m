//
//  RTObject+CoreDataProperties.m
//  HW41
//
//  Created by Руслан on 28.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTObject+CoreDataProperties.h"

@implementation RTObject (CoreDataProperties)

+ (NSFetchRequest<RTObject *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTObject"];
}


@end
