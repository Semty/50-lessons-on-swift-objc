//
//  RTUniversity+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTUniversity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RTUniversity (CoreDataProperties)

+ (NSFetchRequest<RTUniversity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<RTCourse *> *courses;
@property (nullable, nonatomic, retain) NSSet<RTStudent *> *students;

@end

@interface RTUniversity (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(RTCourse *)value;
- (void)removeCoursesObject:(RTCourse *)value;
- (void)addCourses:(NSSet<RTCourse *> *)values;
- (void)removeCourses:(NSSet<RTCourse *> *)values;

- (void)addStudentsObject:(RTStudent *)value;
- (void)removeStudentsObject:(RTStudent *)value;
- (void)addStudents:(NSSet<RTStudent *> *)values;
- (void)removeStudents:(NSSet<RTStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
