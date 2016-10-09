//
//  AppDelegate.swift
//  HW16
//
//  Created by Руслан on 09.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //                                                  *** LEARNER && STUDENT ***
        
        var students = createStudents()
        
        students = students.sorted { student1, student2 in
            return student1.dateOfBirth > student2.dateOfBirth
        }
        
        printStudents(students)
        //                                                  *** MASTER && SUPERMAN ***
        
        var timerDate = Date.init(timeIntervalSinceNow: -(1072224000 + 504576000))
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in

            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "dd.MM.yyyy"
            let nameDayFormatter = DateFormatter()
            nameDayFormatter.dateFormat = "EEEE"
            let monthDayFormatter = DateFormatter()
            monthDayFormatter.dateFormat = "dd"
            
            timerDate = timerDate.addingTimeInterval(86400)
            
            let stringTimerDate = myFormatter.string(from: timerDate)
            print(stringTimerDate)
            
            
            let stringOfDay = nameDayFormatter.string(from: timerDate)
            let stringOfMonthDay = monthDayFormatter.string(from: timerDate)
            
            if stringOfMonthDay == "01" {
                print(stringTimerDate, ", it's the first day of the month!!!")
            }
            
            if stringOfDay == "Sunday" {
                print(stringTimerDate, ", Sunday!!!")
            }
            
            for student in students {
                
                if stringTimerDate == "01.11.2000" {
                    timer.invalidate()
                }
                
                let studentDate = myFormatter.string(from: student.dateOfBirth)
                
                if stringTimerDate == studentDate {
                    print("\n\n\n\(student.name) \(student.surname), HAPPY BIRTHDAY!!!\n\n")
                }
            }
        }
        
        ageDifferenceBetween(students.first!, and: students.last!)
        
        
        return true
    }
    
    func createStudents() -> [Student] {
        
        var tempStudents = [Student]()
        
        for i in 0..<30 {
            
            let studentAlias = "Student" + "\(i)"
            
            let student = Student(alias: studentAlias)
            tempStudents.append(student)
        }
        return tempStudents
    }
    
    func printStudents(_ students: [Student]) {
        
        for student in students {
            
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "dd.MM.yyyy"
            
            let stringDate = myFormatter.string(from: student.dateOfBirth)
            let startDate = myFormatter.date(from: "11.01.2016")!
            
            let calendar = Calendar.current
            
            let age = calendar.dateComponents([.year, .month],
                                              from: student.dateOfBirth,
                                              to: startDate)
            
            print(" Alias: \(student.alias)\n Fullname: \(student.name) \(student.surname)\n",
                  "Date of birth: \(stringDate) (\(age.year!) years(s), \(age.month!) month(s))\n\n")
        }
        
    }
    
    func ageDifferenceBetween(_ student1: Student, and student2: Student) {
        
        let calendar = Calendar.current
        
        let age = calendar.dateComponents([.year, .month, .weekday, .day],
                                          from: student2.dateOfBirth,
                                          to: student1.dateOfBirth)
        
        print("\n\n The youngest student: \(student1.name) \(student1.surname)\n",
              "The oldest student: \(student2.name) \(student2.surname)\n",
              "Age difference is \(age.year!) years, \(age.month!) months, \(age.weekday!) weeks and \(age.day!) days\n\n")
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

