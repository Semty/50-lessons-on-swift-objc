//
//  RTCar+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCar+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RTCar (CoreDataProperties)

+ (NSFetchRequest<RTCar *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *model;
@property (nullable, nonatomic, retain) RTStudent *owner;

@end

NS_ASSUME_NONNULL_END
