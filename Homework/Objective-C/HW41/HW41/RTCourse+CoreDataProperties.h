//
//  RTCourse+CoreDataProperties.h
//  HW41
//
//  Created by Руслан on 28.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCourse+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RTCourse (CoreDataProperties)

+ (NSFetchRequest<RTCourse *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *subject;
@property (nullable, nonatomic, copy) NSString *studyBranch;
@property (nullable, nonatomic, retain) NSSet<RTStudent *> *students;
@property (nullable, nonatomic, retain) RTStudent *teacher;

@end

@interface RTCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(RTStudent *)value;
- (void)removeStudentsObject:(RTStudent *)value;
- (void)addStudents:(NSSet<RTStudent *> *)values;
- (void)removeStudents:(NSSet<RTStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
