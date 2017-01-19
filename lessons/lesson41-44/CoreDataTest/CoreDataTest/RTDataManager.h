//
//  RTDataManager.h
//  CoreDataTest
//
//  Created by Руслан on 19.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RTDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

- (void) generateAndAddUniversity;

+ (RTDataManager *) sharedManager;

@end
