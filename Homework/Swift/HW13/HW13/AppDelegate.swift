//
//  AppDelegate.swift
//  HW13
//
//  Created by Руслан on 02.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //                                                  *** LEARNER && STUDENT && MASTER && SUPERMAN ***
        let student1 = Student(name: "Ruslan(1)")
        let student2 = Student(name: "Dasha(2)")
        let student3 = Student(name: "Akram(3)")
        let student4 = Student(name: "Eduard(4)")
        let student5 = Student(name: "Zahar(5)")
        
        let students = [student1, student2, student3, student4, student5]
        
        let answer = Int(arc4random()) % 10000001
        let maxNumber = 10000000
        let resultClosure: (String, Double) -> Void = { name, time in
            
            print("\(name) ended in \(time) sec!")
            
        }
        
        for student in students {
            
            student.guess1(answer: answer, with: maxNumber, and: resultClosure)     // - GCD
            //student.guess2(answer: answer, with: maxNumber, and: resultClosure)   // - OperationQueue
            
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

