//
//  RTDataManager.m
//  CoreDataTest
//
//  Created by Руслан on 19.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTDataManager.h"
#import "RTStudent+CoreDataClass.h"
#import "RTCar+CoreDataClass.h"
#import "RTUniversity+CoreDataClass.h"
#import "RTCourse+CoreDataClass.h"

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie", @"Akram",
    @"Ruslan", @"Dasha", @"Sergey", @"Sveta", @"Zahar"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook", @"Timchenko",
    @"Makhmudov(a)", @"Astapenkov(a)", @"Kobilkin(a)", @"Tarasov(a)",
    @"Glushko"
};

static NSString* carModelNames[] = {
    
    @"Dodge", @"Toyota", @"BMW", @"Lada", @"Volga"
};

static int namesCount = 56;
static int modelCount = 5;

@implementation RTDataManager

#pragma mark - Main functions

- (void) generateAndAddUniversity {
    
    //NSLog(@"%@", [self.persistentContainer.managedObjectModel entitiesByName]);
    
    /*
     
     // *** Changing and saving entity in context ***
     
     NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"RTStudent"
     inManagedObjectContext:self.persistentContainer.viewContext];
     
     [student setValue:@"Ruslan" forKey:@"firstName"];
     [student setValue:@"Timchenko" forKey:@"lastName"];
     [student setValue:[NSDate dateWithTimeIntervalSinceReferenceDate:0] forKey:@"dateOfBirth"];
     [student setValue:@4 forKey:@"score"];
     
     NSError *error = nil;
     [self.persistentContainer.viewContext save:&error];
     
     if (error) {
     NSLog(@"%@", error.localizedDescription);
     }
     */
    
    
    [self deleteAllObjects];
    
    NSArray *courses = @[ [self addCourseWithName:@"iOS"],
                          [self addCourseWithName:@"Android"],
                          [self addCourseWithName:@"PHP"],
                          [self addCourseWithName:@"Javascript"],
                          [self addCourseWithName:@"HTML"] ];
    
    RTUniversity *university = [self addUniversity];
    
    [university addCourses:[NSSet setWithArray:courses]];
    
    for (int i = 0; i < 100; i++) {
        
        RTStudent *student = [self addRandomStudent];
        
        if (arc4random_uniform(1000) < 500) {
            student.car = [self addRandomCar];
        }
        student.university = university;
        
        NSInteger number = arc4random_uniform((uint32_t)([courses count])) + 1;
        
        while ([student.courses count] < number) {
            
            RTCourse * randomCourse = [courses objectAtIndex:arc4random_uniform((uint32_t)([courses count]))];
            
            if (![student.courses containsObject:randomCourse]) {
                [student addCoursesObject:randomCourse];
            }
        }
    }
    
    [self.persistentContainer.viewContext save:nil];
    
    
    // *** Loading information out of context -> entity ***
    
    // Fetching - /// FIRST ///
    
    //NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //NSEntityDescription *description = [NSEntityDescription entityForName:@"RTCourse"
    //                                               inManagedObjectContext:self.persistentContainer.viewContext];
    //[request setEntity:description];
    //[request setRelationshipKeyPathsForPrefetching:@[ @"courses" ]];
    //[request setFetchBatchSize:20];
    //[request setFetchOffset:10];
    //[request setFetchLimit:45];
    //[request setResultType:NSDictionaryResultType];
    
    /*
     NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
     NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
     
     [request setSortDescriptors:@[ firstNameDescriptor, lastNameDescriptor ]];
     
     NSArray *validNames = @[ @"Ben", @"Clyde", @"Sergey" ];
     
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:  @"score >= 3.0 AND "
     "score <= 3.5 AND "
     "courses.@count >= 3 AND "
     "firstName IN %@", validNames];
     */
    
    /*
     NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
     
     [request setSortDescriptors:@[ nameDescriptor ]];
     
     //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"@max.students.score == 4"];
     
     NSPredicate *predicate =
     [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.car.model == %@).@count > 7", @"BMW"];
     
     [request setPredicate:predicate];
     */
    
    /*
     NSError *requestError = nil;
     NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request
     error:&requestError];
     if (requestError) {
     NSLog(@"%@", requestError.localizedDescription);
     }
     */
    
    // Fetching - /// SECOND ///
    
    /*
     NSFetchRequest *request = [[self.persistentContainer.managedObjectModel fetchRequestTemplateForName:@"FetchStudents"] copy];
     
     NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
     NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
     
     [request setSortDescriptors:@[ firstNameDescriptor, lastNameDescriptor ]];
     
     NSError *requestError = nil;
     NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request
     error:&requestError];
     
     if (requestError) {
     NSLog(@"%@", requestError.localizedDescription);
     }
     
     [self printArray:resultArray];
     */
    
    /*
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"RTCourse"
                                                   inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:description];
    
    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request
                                                                               error:nil];
    
    RTCourse *course = (RTCourse *)([resultArray firstObject]);
    NSLog(@"COURSE: %@", course.name);
    [self printArray:course.studentsWithManyCourses];
     */
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

- (RTStudent *) addRandomStudent {
    
    RTStudent *student = [NSEntityDescription insertNewObjectForEntityForName:@"RTStudent"
                                                       inManagedObjectContext:self.persistentContainer.viewContext];
    
    student.firstName = firstNames[arc4random_uniform(namesCount)];
    student.lastName = lastNames[arc4random_uniform(namesCount)];
    student.score = arc4random_uniform(201) / 100.f + 2.f;
    student.dateOfBirth = [[NSDate alloc] initWithTimeIntervalSince1970:arc4random_uniform(1450656000)];
    
    NSError *error = nil;
    [self.persistentContainer.viewContext save:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return student;
}

- (RTCar *) addRandomCar {
    
    RTCar *car = [NSEntityDescription insertNewObjectForEntityForName:@"RTCar"
                                               inManagedObjectContext:self.persistentContainer.viewContext];
    car.model = carModelNames[arc4random_uniform(modelCount)];
    
    NSError *error = nil;
    [self.persistentContainer.viewContext save:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return car;
}

- (RTUniversity *) addUniversity {
    
    RTUniversity *university = [NSEntityDescription insertNewObjectForEntityForName:@"RTUniversity"
                                                             inManagedObjectContext:self.persistentContainer.viewContext];
    university.name = @"HSE";
    
    NSError *error = nil;
    [self.persistentContainer.viewContext save:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return university;
}

- (RTCourse *) addCourseWithName:(NSString *)name {
    
    RTCourse *course = [NSEntityDescription insertNewObjectForEntityForName:@"RTCourse"
                                                     inManagedObjectContext:self.persistentContainer.viewContext];
    course.name = name;
    
    NSError *error = nil;
    [self.persistentContainer.viewContext save:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return course;
}

- (void) deleteAllObjects {
    
    NSArray *resultArray = [self allObjects];
    
    for (id object in resultArray) {
        [self.persistentContainer.viewContext deleteObject:object];
    }
    [self.persistentContainer.viewContext save:nil];
}

- (void) printAllObjects {
    
    NSArray *resultArray = [self allObjects];
    
    [self printArray:resultArray];
}

- (void) printArray:(NSArray *) array {
    
    for (id object in array) {
        
        if ([object isKindOfClass:[RTCar class]]) {
            RTCar *car = (RTCar *)object;
            NSLog(@"CAR: %@, OWNER: %@ %@", car.model, car.owner.firstName, car.owner.lastName);
        }
        
        if ([object isKindOfClass:[RTStudent class]]) {
            RTStudent *student = (RTStudent *)object;
            NSLog(@"STUDENT: %@ %@, SCORE: %1.1f, COURSES: %ld",    student.firstName, student.lastName,
                  student.score, [student.courses count]);
        }
        
        if ([object isKindOfClass:[RTUniversity class]]) {
            RTUniversity *university = (RTUniversity *)object;
            NSLog(@"UNIVERSITY: %@, STUDENTS: %ld", university.name, [university.students count]);
        }
        
        if ([object isKindOfClass:[RTCourse class]]) {
            RTCourse *course = (RTCourse *)object;
            NSLog(@"COURSE: %@, STUDENTS: %ld", course.name, [course.students count]);
        }
    }
    
    NSLog(@"COUNT: %ld", [array count]);
}

#pragma mark - Shared manager

+ (RTDataManager *) sharedManager {
    
    static RTDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RTDataManager alloc] init];
        //[manager generateAndAddUniversity];
    });
    
    return manager;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreDataTest"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                
                if (error != nil) {
                    
                    [[NSFileManager defaultManager] removeItemAtURL:storeDescription.URL
                                                              error:&error];
                    
                    [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
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
