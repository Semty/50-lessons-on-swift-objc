//
//  BadDoctor.swift
//  HW9
//
//  Created by Руслан on 22.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class BadDoctor: NSObject, PatientDelegate {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
// MARK: - private properties
    
    var headacheCount = [String]()
    var stomachacheCount = [String]()
    var soreThroatCount = [String]()
    
// MARK: - Bad doctor methods
    
    func tellTheFairyTale(for patient: Patient) {
        print("Bad doctor \(self.name) tells the fairy tale. Patient \(patient.name) feels worse")
    }
    
    func runAway() {
        print("Bad doctor \(self.name) runs away!")
    }
    
    func request() {
        print("Can you tell the people that I make you healthy, please?))")
    }
    
    func clearCount() {
        self.headacheCount.removeAll()
        self.stomachacheCount.removeAll()
        self.soreThroatCount.removeAll()
    }
    
    func report() {
        
        print("          *** BAD DOCTOR \(self.name.uppercased()) REPORT ***")
        
        print("Sore throat: \(soreThroatCount.count) patient(s)")
        for (index, patientName) in soreThroatCount.enumerated() {
            print("\(index + 1). \(patientName)")
        }
        print("")
        
        print("Headache: \(headacheCount.count) patient(s)")
        for (index, patientName) in headacheCount.enumerated() {
            print("\(index + 1). \(patientName)")
        }
        print("")
        
        print("Stomachache: \(stomachacheCount.count) patient(s)")
        for (index, patientName) in stomachacheCount.enumerated() {
            print("\(index + 1). \(patientName)")
        }
        print("\n\n\n")
    }

    
// MARK: - PatientDelegate
    
    func patientFeelsBad(patient: Patient) {
        
        print("Patient \(patient.name) feels bad. Bad doctor: \(self.name)")
        
        switch patient.symptom! {
            
        case .soreThroat:
            soreThroatCount.append(patient.name)
            
            print("\(patient.name) has a sore throat\n",
                "His temperature is \(patient.temperature)")
            
            switch patient.temperature {
            case 36..<38:
                self.tellTheFairyTale(for: patient)
                print("", terminator: "\n\n")
            case 38..<41:
                self.runAway()
                print("", terminator: "\n\n")
            default:
                break
            }
            
        case .stomachache:
            stomachacheCount.append(patient.name)
            
            print("\(patient.name) has a stomachache\n",
                "His temperature is \(patient.temperature)")
            
            switch patient.temperature {
            case 36..<38:
                self.request()
                print("", terminator: "\n\n")
            case 38..<41:
                self.tellTheFairyTale(for: patient)
                print("", terminator: "\n\n")
            default:
                break
            }
            
        case .headache:
            headacheCount.append(patient.name)
            
            print("\(patient.name) has a headache\n",
                "His temperature is \(patient.temperature)")
            
            self.tellTheFairyTale(for: patient)
            print("", terminator: "\n\n")
        }
    }
}
