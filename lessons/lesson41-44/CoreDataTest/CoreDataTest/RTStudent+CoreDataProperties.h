//
//  RTStudent+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RTStudent (CoreDataProperties)

+ (NSFetchRequest<RTStudent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateOfBirth;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) double score;
@property (nullable, nonatomic, retain) RTCar *car;
@property (nullable, nonatomic, retain) NSSet<RTCourse *> *courses;
@property (nullable, nonatomic, retain) RTUniversity *university;

@end

@interface RTStudent (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(RTCourse *)value;
- (void)removeCoursesObject:(RTCourse *)value;
- (void)addCourses:(NSSet<RTCourse *> *)values;
- (void)removeCourses:(NSSet<RTCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
