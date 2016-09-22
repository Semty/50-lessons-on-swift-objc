//
//  Doctor.swift
//  HW9
//
//  Created by Руслан on 22.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Doctor: NSObject, PatientDelegate {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
// MARK: - Doctor private properties
    
    var headacheCount = [String]()
    var stomachacheCount = [String]()
    var soreThroatCount = [String]()
    
// MARK: - Doctor methods
    
    func clearCount() {
        self.headacheCount.removeAll()
        self.stomachacheCount.removeAll()
        self.soreThroatCount.removeAll()
    }
    
    func report() {
        
        print("          *** GOOD DOCTOR \(self.name.uppercased()) REPORT ***")
        
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
        
        print("Patient \(patient.name) feels bad. Good doctor: \(self.name)")
        
        switch patient.symptom! {
            
        case .soreThroat:
            soreThroatCount.append(patient.name)
            
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
            stomachacheCount.append(patient.name)
            
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
            headacheCount.append(patient.name)
            
            print("\(patient.name) has a headache\n",
                "His temperature is \(patient.temperature)")
            
            patient.takePill()
            print("", terminator: "\n\n")
        }
    }

}
