//
//  AppDelegate.swift
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var patients = [PatientSuperman]()

    typealias VoidClosure = () -> Void
    typealias StringClosure = (String) -> String
    typealias Doctor = (Patient) -> Void

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //                                                  *** LEARNER ***
        print("\n\nLEVEL: LEARNER")
        let closure1: VoidClosure = {
            print("\n\nInput: void, output: void, number: closure1")
        }
        
        let string1 = "string1"
        
        let closure2: StringClosure = {
            string in
            return "\n\nInput: \(string), output: \(string), number: closure2"
        }
        
        self.closureMethodWith(voidClosure: closure1, andStringClosure: closure2, withParameter: string1)
        
        //                                                  *** STUDENT ***
        print("\n\nLEVEL: STUDENT\n\n")
        let student1 = Student(name: "Ruslan", surname: "Timchenko")
        let student2 = Student(name: "Eduard", surname: "Nugamanov")
        let student3 = Student(name: "Akram" , surname: "Makhmudov")
        let student4 = Student(name: "Dasha" , surname: "Timchenko")
        let student5 = Student(name: "Galya" , surname: "Tarasova" )
        let student6 = Student(name: "Igor"  , surname: "Tarasov"  )
        
        var students = [student1, student2, student3, student4, student5, student6]
        
        students = students.sorted { first, second in
            if first.surname != second.surname {
                return first.surname < second.surname
            } else {
                return first.name < second.name
            }
        }
        
        for student in students {
            print(student.name, student.surname)
        }
        //                                                  *** MASTER ***
        print("\n\nLEVEL: MASTER\n\n")
        let doctor: Doctor = { patient in
            
            print("Patient \(patient.name) feels bad.")
            
            switch patient.symptom! {
                
            case .soreThroat:
                
                print("\(patient.name) has a sore throat\n",
                    "His temperature is \(patient.temperature)")
                
                switch patient.temperature {
                case 36..<38:
                    patient.takePill()
                    print("", terminator: "\n\n")
                case 38..<41:
                    patient.makeShot()
                    print("", terminator: "\n\n")
                default:
                    break
                }
                
            case .stomachache:
                
                print("\(patient.name) has a stomachache\n",
                    "His temperature is \(patient.temperature)")
                
                switch patient.temperature {
                    
                case 36..<38:
                    print("You should have a rest", terminator: "\n\n")
                case 38..<41:
                    patient.makeShot()
                    print("", terminator: "\n\n")
                default:
                    break
                }
                
            case .headache:
                
                print("\(patient.name) has a headache\n",
                    "His temperature is \(patient.temperature)")
                
                patient.takePill()
                print("", terminator: "\n\n")
            }
        }
        
        for student in students {
            student.doctorsClosure(doctor: doctor)
        }
        //                                                  *** SUPERMAN ***
        print("\n\nLEVEL: SUPERMAN\n\n")
        let studentSuperman1 = StudentSuperman(name: "Ruslan", surname: "Timchenko")
        let studentSuperman2 = StudentSuperman(name: "Eduard", surname: "Nugamanov")
        let studentSuperman3 = StudentSuperman(name: "Akram" , surname: "Makhmudov")
        let studentSuperman4 = StudentSuperman(name: "Dasha" , surname: "Timchenko")
        let studentSuperman5 = StudentSuperman(name: "Galya" , surname: "Tarasova" )
        let studentSuperman6 = StudentSuperman(name: "Igor"  , surname: "Tarasov"  )
        
        self.patients = [ studentSuperman1, studentSuperman2, studentSuperman3, studentSuperman4, studentSuperman5, studentSuperman6 ]
        
        return true
    }
    
    func closureMethodWith(voidClosure: VoidClosure, andStringClosure: StringClosure, withParameter string: String) {
        
        voidClosure()
        
        let result = andStringClosure(string)
        print(result)
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

