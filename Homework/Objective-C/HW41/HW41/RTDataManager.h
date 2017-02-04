//
//  RTDataManager.h
//  HW41
//
//  Created by Руслан on 22.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RTDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
- (void) printArray:(NSArray *) array;

+ (RTDataManager *) sharedManager;

@end
