//
//  PatientSuperman.swift
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class PatientSuperman: NSObject {
    
    typealias DoctorSuperman = (PatientSuperman) -> Void
    
    enum Symptoms {
        case soreThroat
        case stomachache
        case headache
    }
    
    // MARK: - Patient properties
    
    var name: String
    var temperature: Float
    var symptom: Symptoms!
    
    private var doctor: DoctorSuperman = { patient in
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

    
    // MARK: - Patient init
    
    init(name: String) {
        self.name = name
        self.temperature = Float(Int(arc4random()) % 50) / 10 + 36
        super.init()
        
        self.perform(#selector(doctorsClosure), with: nil, afterDelay: TimeInterval(arc4random() % 11 + UInt32(5)))
        
    }
    
    // MARK: - Patient methods
    
    func howAreYou() -> Bool {
        
        let isOk: Bool = arc4random() % 2 == 1 ? true : false;
        
        if !isOk {
            let intSymptom = arc4random() % 3;
            
            switch intSymptom {
            case 0:
                self.symptom = .soreThroat
                return isOk
            case 1:
                self.symptom = .stomachache
                return isOk
            case 2:
                self.symptom = .headache
                return isOk
            default: return isOk
            }
        } else {
            print("\(self.name) is completely healthy", terminator: "\n\n")
            return isOk
        }
    }
    
    func takePill() {
        print("\(self.name) takes a pill")
    }
    
    func makeShot() {
        print("\(self.name) make a shot")
    }
    
    func doctorsClosure() {
        if !self.howAreYou() {
            doctor(self)
        }
    }

}
