//
//  AppDelegate.swift
//  HW8
//
//  Created by Руслан on 20.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //                                      *** LEARNER ***
        let ruslan = Student(name: "Ruslan", surname: "Timchenko")
        let eduard = Student(name: "Eduard", surname: "Nugamanov")
        let akram = Student(name: "Akram", surname: "Makhmudov")
        let igor = Student(name: "Igor", surname: "Tarasov")
        let dasha = Student(name: "Daria", surname: "Timchenko")
        let zahar = Student(name: "Zahar", surname: "Maksimenko")
        let danil = Student(name: "Danil", surname: "Kobilkin")
        
        let friends = ["Ruslan Timchenko": ruslan,
            "Eduard Nugamanov": eduard,
            "Akram Makhmudov": akram,
            "Igor Tarasov": igor,
            "Daria Timchenko": dasha,
            "Zahar Maksimenko": zahar,
            "Danil Kobilkin": danil]
        
        print("\(friends)", terminator: "\n\n\n")
        
        //                                      *** STUDENT ***
        
        for student in friends.values {
            print("\(student.name) \(student.surname). I am saying \(student.sayHello())")
        }
        print("\n\n\n")
        //                                       *** MASTER ***
        let sortedKeys = friends.keys.sort {
            return $0 < $1
        }
        
        for key in sortedKeys {
            let student = friends[key]!
            
            print("\(student.name) \(student.surname). I am saying \(student.sayHello())")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

