//
//  AppDelegate.swift
//  HW15
//
//  Created by Руслан on 04.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //                                                  *** LEARNER ***
        // subjectType 0 means "nothing"
        let student1 = Student(name: "Ruslan", subjectType: 0)
        let student2 = Student(name: "Eduard", subjectType: 0)
        let student3 = Student(name: "Akram ", subjectType: 0)
        let student4 = Student(name: "Zahar ", subjectType: 0)
        let student5 = Student(name: "Dasha ", subjectType: 0)
        
        let students = [student1, student2, student3, student4, student5]
        
        for student in students {
            student.setRandomSubjects()
        }
        
        print("\n\n*** LEARNER ***")
        print("\(printArray(of: students))")
        //                                                  *** STUDENT ***
        
        var humanitarians = [Student]()
        var techies = [Student]()
        
        for student in students {
            
            let isTech = arc4random() % 2 == 1 ? true : false
            
            if isTech {
                techies.append(student)
            } else {
                humanitarians.append(student)
            }
        }
        
        print("*** STUDENT ***\n\nHumanitarians:\n\(printArray(of: humanitarians))\n",
              "Techies:\n\(printArray(of: techies))",
              "\nProgrammers: \(howManyProgrammers(in: students))\n")
        
        //                                                  *** MASTER ***
        print("\n *** MASTER *** \n")
        
        biologistsDiscrimination(for: students)
        
        print("\(printArray(of: students))")
        
        //                                                  *** SUPERMAN ***
        
        let randomNumber = arc4random()
        var reversedBitsNumber = ""
        var bitsNumber = ""
        
        for i in 0..<32 {
            
            if randomNumber & UInt32((1 << i)) != 0 {
                reversedBitsNumber += "1"
            } else {
                reversedBitsNumber += "0"
            }
        }
        // reverse our string
        for character in reversedBitsNumber.characters.reversed() {
            bitsNumber += String(character)
        }
        
        print("\n *** SUPERMAN *** \n\n\(randomNumber) = \(bitsNumber)\n\n")
        
        return true
    }
    
    func biologistsDiscrimination(for students: [Student]) {
        
        for student in students {
            if student.subjectType & Student.SubjectType.biology.rawValue != 0 {
                student.subjectType &= ~Student.SubjectType.biology.rawValue
                print("\(student.name)'s biology is deleted!")
            }
        }
    }
    
    func howManyProgrammers(`in` students: [Student]) -> Int {
        var programmersCount = 0
        
        for student in students {
            
            if student.subjectType & Student.SubjectType.development.rawValue != 0 {
                programmersCount += 1
            }
            
        }
        return programmersCount
    }
    
    func printArray(of students: [Student]) -> String {
        
        var resultString = ""
        
        for student in students {
            resultString += "\(student)"
        }
        return resultString
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

