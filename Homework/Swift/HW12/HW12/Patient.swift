//
//  Patient.swift
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Patient {
    
    enum Symptoms {
        case soreThroat
        case stomachache
        case headache
    }
    
    // MARK: - Patient properties
    
    var name: String
    var temperature: Float
    var symptom: Symptoms!
    
    // MARK: - Patient init
    
    init(name: String) {
        self.name = name
        self.temperature = Float(Int(arc4random()) % 50) / 10 + 36
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
    
    func doctorsClosure(doctor: (Patient) -> Void) {
        if !self.howAreYou() {
            doctor(self)
        }
    }
}
