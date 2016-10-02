//
//  Student.swift
//  HW13
//
//  Created by Руслан on 02.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation
import UIKit

class Student: NSObject {
    
    let name: String
    static let studentOperationQueue = OperationQueue()
    
    static let studentDispatchQueue = DispatchQueue(label: "com.rstimchenko.hw13.studentDispatchQueue",
                                                    qos: DispatchQoS.default, attributes: .concurrent,
                                                    autoreleaseFrequency: .workItem, target: nil)
    
    init(name: String) {
        self.name = name
    }
    
    func guess1(answer: Int, with maxNumber: Int, and resultClosure: @escaping (String, Double) -> Void) {
        
        Student.studentDispatchQueue.async {
            
            unowned let weakSelf = self
            
            var tempAnswer = maxNumber
            var count = -1
            
            let startTime = CACurrentMediaTime()
            while tempAnswer != answer {
                tempAnswer = Int(arc4random()) % maxNumber
                count += 1
            }
            
            resultClosure(weakSelf.name, CACurrentMediaTime() - startTime)
        }
    }
    
    func guess2(answer: Int, with maxNumber: Int, and resultClosure: @escaping (String, Double) -> Void) {
        
        Student.studentOperationQueue.addOperation {
    
            unowned let weakSelf = self
            
            var tempAnswer = maxNumber
            var count = -1
            
            let startTime = CACurrentMediaTime()
            while tempAnswer != answer {
                tempAnswer = Int(arc4random()) % maxNumber
                count += 1
            }
            
            resultClosure(weakSelf.name, CACurrentMediaTime() - startTime)
        }
    }
}
