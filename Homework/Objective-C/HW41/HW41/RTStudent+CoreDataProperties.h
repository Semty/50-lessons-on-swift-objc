//
//  RTStudent+CoreDataProperties.h
//  HW41
//
//  Created by Руслан on 28.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudent+CoreDataClass.h"
#import "RTCourse+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTStudent (CoreDataProperties)

+ (NSFetchRequest<RTStudent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, retain) NSSet<RTCourse *> *learningCourses;
@property (nullable, nonatomic, retain) NSSet<RTCourse *> *teachingCourses;

@end

@interface RTStudent (CoreDataGeneratedAccessors)

- (void)addLearningCoursesObject:(RTCourse *)value;
- (void)removeLearningCoursesObject:(RTCourse *)value;
- (void)addLearningCourses:(NSSet<RTCourse *> *)values;
- (void)removeLearningCourses:(NSSet<RTCourse *> *)values;

- (void)addTeachingCoursesObject:(RTCourse *)value;
- (void)removeTeachingCoursesObject:(RTCourse *)value;
- (void)addTeachingCourses:(NSSet<RTCourse *> *)values;
- (void)removeTeachingCourses:(NSSet<RTCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
