//
//  RTCourse+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Руслан on 18.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCourse+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RTCourse (CoreDataProperties)

+ (NSFetchRequest<RTCourse *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<RTStudent *> *students;
@property (nullable, nonatomic, retain) RTUniversity *university;
@property (nullable, nonatomic, retain) NSArray *bestStudents;
@property (nullable, nonatomic, retain) NSArray *studentsWithManyCourses;

@end

@interface RTCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(RTStudent *)value;
- (void)removeStudentsObject:(RTStudent *)value;
- (void)addStudents:(NSSet<RTStudent *> *)values;
- (void)removeStudents:(NSSet<RTStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
