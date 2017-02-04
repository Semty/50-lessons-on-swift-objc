//
//  RTDataManager.m
//  HW41
//
//  Created by Руслан on 22.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTDataManager.h"
#import "RTStudent+CoreDataClass.h"
#import "RTCourse+CoreDataClass.h"

@implementation RTDataManager

#pragma mark - Main functions

- (void) generateAndAddStudent {
    
    //[self deleteAllObjects];
    
    RTStudent *student = [NSEntityDescription insertNewObjectForEntityForName:@"RTStudent"
                                                       inManagedObjectContext:self.persistentContainer.viewContext];
    student.firstName = @"Akram";
    student.lastName = @"Makhmudov";
    student.email = @"akram0898@gmail.com";
    
    [self.persistentContainer.viewContext save:nil];
}

#pragma mark - Helpful functions

- (NSArray *) allObjects {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"RTObject"
                                                   inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:description];
    //[request setResultType:NSDictionaryResultType];
    
    NSError *requestError = nil;
    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request
                                                                               error:&requestError];
    if (requestError) {
        NSLog(@"%@", requestError.localizedDescription);
    }
    return resultArray;
}

- (void) deleteAllObjects {
    
    NSArray *resultArray = [self allObjects];
    
    for (id object in resultArray) {
        [self.persistentContainer.viewContext deleteObject:object];
    }
    [self.persistentContainer.viewContext save:nil];
}

- (void) printArray:(NSArray *) array {
    
    for (id object in array) {
        
        if ([object isKindOfClass:[RTStudent class]]) {
            RTStudent *student = (RTStudent *)object;
            NSLog(@"STUDENT: %@ %@, TEACHING COURSES: %@, LEARNING COURSES: %@",
                                                            student.firstName, student.lastName,
                                                            [student.teachingCourses anyObject].name,
                                                            [student.learningCourses anyObject].name);
        }
        
        if ([object isKindOfClass:[RTCourse class]]) {
            RTCourse *course = (RTCourse *)object;
            NSLog(@"\n\nCOURSE NAME: %@\nSUBJECT: %@\nSTUDY BRANCH: %@\nTEACHER: %@ %@\nSTUDENTS: %ld\n\n",
                  course.name, course.subject, course.studyBranch, course.teacher.firstName,
                  course.teacher.lastName, [course.students count]);
        }
        
    }
    
    NSLog(@"COUNT: %ld", (unsigned long)[array count]);
}

#pragma mark - Shared manager

+ (RTDataManager *) sharedManager {
    
    static RTDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RTDataManager alloc] init];
        //[manager deleteAllObjects];
        //[manager generateAndAddStudent];
        [manager printArray:[manager allObjects]];
    });
    
    return manager;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"HW41"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription,
                                                                              NSError *error) {
                
                if (error != nil) {
                    
                    [[NSFileManager defaultManager] removeItemAtURL:storeDescription.URL
                                                              error:&error];
                    
                    [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription,
                                                                                      NSError *error) {
                        if (error != nil) {
                            NSLog(@"%@", error.localizedDescription);
                        }
                    }];
                    
                }
                
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
