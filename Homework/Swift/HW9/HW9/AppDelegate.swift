//
//  AppDelegate.swift
//  HW9
//
//  Created by Руслан on 22.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("\n\n\n\n")
        //                                      *** LEARNER ***
        
        let patient1 = Patient(name: "Ruslan")
        let patient2 = Patient(name: "Akram")
        let patient3 = Patient(name: "Eduard")
        let patient4 = Patient(name: "Zahar")
        let patient5 = Patient(name: "Igor")
        
        let doctor = Doctor(name: "Nastya")
        
        //patient1.delegate = doctor
        patient2.delegate = doctor
        //patient3.delegate = doctor
        patient4.delegate = doctor
        //patient5.delegate = doctor
        
        /*let patients = [patient1, patient2, patient3, patient4, patient5]
        
        for patient in patients {
            patient.howAreYou()
        }
        print("\n\n")*/
        //                                      *** STUDENT ***
        let badDoctor1 = BadDoctor(name: "Maksim")
        let badDoctor2 = BadDoctor(name: "Zhenya")
        
        patient1.delegate = badDoctor1
        patient3.delegate = badDoctor2
        patient5.delegate = badDoctor1
        
        /*let patients = [patient1, patient2, patient3, patient4, patient5]
        
        for patient in patients {
            patient.howAreYou()
        }
        print("\n\n")*/
        //                                      *** MASTER && SUPERMAN ***
        let patient6 = Patient(name: "Dasha")
        let patient7 = Patient(name: "Misha")
        let patient8 = Patient(name: "Ilya")
        
        patient6.delegate = doctor
        patient7.delegate = doctor
        patient8.delegate = doctor
        
        let patients = [patient1, patient2, patient3, patient4, patient5, patient6, patient7, patient8]
        let doctors: [PatientDelegate] = [doctor, badDoctor1, badDoctor2]
        
        print("\n\n\n                                                          *** DAY 1 ***\n\n")
        
        for patient in patients {
            patient.howAreYou()
        }
        print("\n\n")
        
        doctor.report()
        badDoctor1.report()
        badDoctor2.report()
        print("\n")
        
        for patient in patients {
            if let patientFeedback = patient.feedback {
                if patientFeedback == .dislike {
                    print("\(patient.name) dislikes his doctor. He'll change him")
                    patient.change(doctor: patient.delegate, from: doctors)
                    print("\n")
                }
            }
        }
        
        doctor.clearCount()
        badDoctor1.clearCount()
        badDoctor2.clearCount()
        
        print("\n\n\n                                                          *** DAY 2 ***\n\n")
        
        for patient in patients {
            patient.howAreYou()
        }
        print("\n\n")
        
        doctor.report()
        badDoctor1.report()
        badDoctor2.report()
        print("\n")
        
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

