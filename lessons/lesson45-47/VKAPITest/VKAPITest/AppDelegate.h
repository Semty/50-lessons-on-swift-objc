//
//  AppDelegate.h
//  VKAPITest
//
//  Created by Руслан on 11.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

