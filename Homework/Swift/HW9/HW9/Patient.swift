//
//  Patient.swift
//  HW9
//
//  Created by Руслан on 22.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Patient: NSObject {

    enum Symptoms {
        case soreThroat
        case stomachache
        case headache
    }
    
    enum Feedback: Int {
        case like
        case dislike
    }
    
// MARK: - Patient properties
    
    let name: String
    var temperature: Float
    var delegate: PatientDelegate!
    var symptom: Symptoms!
    var feedback: Feedback!
    
// MARK: - Patient init
    
    init(name: String) {
        self.name = name
        self.temperature = Float(Int(arc4random()) % 50) / 10 + 36
    }
    
// MARK: - Patient methods
    
    func howAreYou() {
        
        let isOk: Bool = arc4random() % 2 == 1 ? true : false;
        
        if !isOk {
            let intSymptom = arc4random() % 3;
            
            switch intSymptom {
            case 0:
                self.symptom = .soreThroat
            case 1:
                self.symptom = .stomachache
            case 2:
                self.symptom = .headache
            default: break
            }
            
            self.delegate.patientFeelsBad(patient: self)
            
            self.feedback = (arc4random() % 2) == 0 ? .like : .dislike
        } else {
            print("\(self.name) is completely healthy", terminator: "\n\n")
        }
    }
    
    func takePill() {
        print("\(self.name) takes a pill")
    }
    
    func makeShot() {
        print("\(self.name) make a shot")
    }
    
    func change(doctor: PatientDelegate, from doctors: [PatientDelegate]) {
        
        for newDoctor in doctors {
            if doctor.name != newDoctor.name {
                self.delegate = newDoctor
                print("Patient \(self.name) has a new doctor. His(Her) name is \(newDoctor.name)")
                break
            }
        }
    }
}

// MARK: - PatientDelegate

protocol PatientDelegate {
    
    var name: String { get }
    
    func patientFeelsBad(patient: Patient)
    
}
