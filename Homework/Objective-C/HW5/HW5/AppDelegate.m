//
//  AppDelegate.m
//  Lesson5
//
//  Created by Руслан on 15.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTHuman.h"
#import "RTCyclist.h"
#import "RTRunner.h"
#import "RTSwimmer.h"
#import "RTBoxer.h"
#import "RTAnimal.h"
#import "RTDog.h"
#import "RTCat.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Level:                                   ***LEARNER***
    RTHuman* human = [[RTHuman alloc] init];
    RTCyclist* cyclist = [[RTCyclist alloc] init];
    RTRunner* runner = [[RTRunner alloc] init];
    RTSwimmer* swimmer = [[RTSwimmer alloc] init];
    
    human.name = @"Zahar";
    human.height = 174.5f;
    human.weight = 66.5f;
    human.gender = @"Male";
    
    cyclist.name = @"Ruslan";
    cyclist.height = 182.0f;
    cyclist.weight = 61.5f;
    cyclist.gender = @"Male";
    
    runner.name = @"Eduard";
    runner.height = 178.3f;
    runner.weight = 66.2f;
    runner.gender = @"Male";
    
    swimmer.name = @"Galya";
    swimmer.height = 164.6f;
    swimmer.weight = 52.1f;
    swimmer.gender = @"Female";
    /*
    NSArray* people = @[human, cyclist, runner, swimmer];
    
    for (RTHuman* human in people) {
        NSLog(@"Name: %@", human.name);
        NSLog(@"Height: %f", human.height);
        NSLog(@"Weight: %f", human.weight);
        NSLog(@"Gender: %@", human.gender);
        [human movement];
        NSLog(@"\n");
    }
    */
    
    // Level:                                   ***STUDENT***
    RTBoxer* boxer = [[RTBoxer alloc] init];
    
    boxer.name = @"Akram";
    boxer.height = 174.5f;
    boxer.weight = 64.7f;
    boxer.gender = @"Male";
    boxer.skinColor = @"White";
    boxer.nationality = @"Tajik";
    /*
    NSArray* people = @[human, cyclist, runner, swimmer, boxer];
    
    for (RTHuman* human in people.reverseObjectEnumerator) {
        NSLog(@"Name: %@", human.name);
        NSLog(@"Height: %f", human.height);
        NSLog(@"Weight: %f", human.weight);
        NSLog(@"Gender: %@", human.gender);
        if ([human isMemberOfClass:[RTBoxer class]]) {
            NSLog(@"Skin color: %@", ((RTBoxer*)human).skinColor);
            NSLog(@"Nationality: %@", ((RTBoxer*)human).nationality);
        }
        [human movement];
        NSLog(@"\n");
    }
     */
    // Level:                                   ***MASTER***
    RTAnimal* animal = [[RTAnimal alloc] init];
    RTDog* dog = [[RTDog alloc] init];
    RTCat* cat = [[RTCat alloc] init];
    
    dog.species = @"Dog";
    dog.name = @"Sharik";
    dog.age = 10;
    cat.species = @"Cat";
    cat.age = 2;
    cat.name = @"Tosya";
    /*
    NSArray* peopleAndAnimals = @[human, cyclist, dog, swimmer, boxer, animal, runner, cat];
    
    for (int i = 0; i < [peopleAndAnimals count]; i++) {
        if ([peopleAndAnimals[i] isKindOfClass:[RTHuman class]]) {
            RTHuman* tempHuman = (RTHuman*)peopleAndAnimals[i];
            NSLog(@"*Human*");
            NSLog(@"Name: %@", tempHuman.name);
            NSLog(@"Height: %f", tempHuman.height);
            NSLog(@"Weight: %f", tempHuman.weight);
            NSLog(@"Gender: %@", tempHuman.gender);
            if ([tempHuman isMemberOfClass:[RTBoxer class]]) {
                NSLog(@"Skin color: %@", ((RTBoxer*)tempHuman).skinColor);
                NSLog(@"Nationality: %@", ((RTBoxer*)tempHuman).nationality);
            }
            [tempHuman movement];
            NSLog(@"\n");
        } else if ([peopleAndAnimals[i] isKindOfClass:[RTAnimal class]]) {
            RTAnimal* tempAnimal = (RTAnimal*)peopleAndAnimals[i];
            NSLog(@"*Animal*");
            NSLog(@"Species: %@", tempAnimal.species);
            NSLog(@"Name: %@", tempAnimal.name);
            NSLog(@"Age: %d", tempAnimal.age);
            [tempAnimal movement];
            NSLog(@"\n");
        }
    }*/
    // Level:                                   ***STAR***
    /*
    NSArray* people = @[human, cyclist, runner, swimmer, boxer];
    NSArray* animals = @[animal, dog, cat];
    
    for (int i = 0; i < MAX([people count], [animals count]); i++) {
        if (i < [people count]) {
            RTHuman* tempHuman = (RTHuman*)people[i];
            NSLog(@"***Human***");
            NSLog(@"Name: %@", tempHuman.name);
            NSLog(@"Height: %f", tempHuman.height);
            NSLog(@"Weight: %f", tempHuman.weight);
            NSLog(@"Gender: %@", tempHuman.gender);
            if ([tempHuman isMemberOfClass:[RTBoxer class]]) {
                NSLog(@"Skin color: %@", ((RTBoxer*)tempHuman).skinColor);
                NSLog(@"Nationality: %@", ((RTBoxer*)tempHuman).nationality);
            }
            [tempHuman movement];
            NSLog(@"\n");
        }
        if (i < [animals count]) {
            RTAnimal* tempAnimal = (RTAnimal*)animals[i];
            NSLog(@"***Animal***");
            NSLog(@"Species: %@", tempAnimal.species);
            NSLog(@"Name: %@", tempAnimal.name);
            NSLog(@"Age: %d", tempAnimal.age);
            [tempAnimal movement];
            NSLog(@"\n");
        }
    }*/
    // Level:                               ***SUPERMAN***
    NSArray* peopleAndAnimals = @[human, cyclist, runner, animal, dog, swimmer, boxer, cat];
    
    NSArray* sortedPeopleAndAnimals = [peopleAndAnimals sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {

        if ([a isKindOfClass:[RTHuman class]] && [b isKindOfClass:[RTHuman class]]) {
            return [[(RTHuman*)a name] compare: [(RTHuman*)b name]];
        }
        if ([a isKindOfClass:[RTAnimal class]] && [b isKindOfClass:[RTAnimal class]]) {
            return [[(RTAnimal*)a name] compare: [(RTAnimal*)b name]];
        }
        if ([a isKindOfClass:[RTAnimal class]]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    
    for (int i = 0; i < [sortedPeopleAndAnimals count]; i++) {
        if ([sortedPeopleAndAnimals[i] isKindOfClass:[RTHuman class]]) {
            RTHuman* tempHuman = (RTHuman*)sortedPeopleAndAnimals[i];
            NSLog(@"*Human*");
            NSLog(@"Name: %@", tempHuman.name);
            NSLog(@"Height: %f", tempHuman.height);
            NSLog(@"Weight: %f", tempHuman.weight);
            NSLog(@"Gender: %@", tempHuman.gender);
            if ([tempHuman isMemberOfClass:[RTBoxer class]]) {
                NSLog(@"Skin color: %@", ((RTBoxer*)tempHuman).skinColor);
                NSLog(@"Nationality: %@", ((RTBoxer*)tempHuman).nationality);
            }
            [tempHuman movement];
            NSLog(@"\n");
        } else if ([sortedPeopleAndAnimals[i] isKindOfClass:[RTAnimal class]]) {
            RTAnimal* tempAnimal = (RTAnimal*)sortedPeopleAndAnimals[i];
            NSLog(@"*Animal*");
            NSLog(@"Name: %@", tempAnimal.name);
            NSLog(@"Species: %@", tempAnimal.species);
            NSLog(@"Age: %d", tempAnimal.age);
            [tempAnimal movement];
            NSLog(@"\n");
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
