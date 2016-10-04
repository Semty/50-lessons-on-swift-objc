//
//  Student.swift
//  HW15
//
//  Created by Руслан on 04.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Student: CustomStringConvertible {
    
    enum SubjectType: Int {
        
        case biology        = 0b00000001
        case anatomy        = 0b00000010
        case math           = 0b00000100
        case development    = 0b00001000
        case engineering    = 0b00010000
        case art            = 0b00100000
        case psychology     = 0b01000000
        
    }
    
    let name: String
    var subjectType: Student.SubjectType.RawValue
    
    var description: String {
        return "\n\(name)'s studies:\nbiology: \(answerByType(.biology))\nanatomy:\(answerByType(.anatomy))\nmath: \(answerByType(.math))\ndevelopment: \(answerByType(.development))\nengineering: \(answerByType(.engineering))\nart: \(answerByType(.art))\npsychology: \(answerByType(.psychology))\n"
    }
    
    init(name: String, subjectType: Student.SubjectType.RawValue) {
        self.name = name
        self.subjectType = subjectType
    }
    
    func setRandomSubjects() {
        for i in 0..<7 {
            let isSubject = arc4random() % 2 == 1 ? true : false
            if isSubject {
                self.subjectType |= 1 << i
            }
        }
    }
    
    func answerByType(_ type: Student.SubjectType) -> String {
        return type.rawValue & self.subjectType == 0 ? "No" : "Yes"
    }
}
