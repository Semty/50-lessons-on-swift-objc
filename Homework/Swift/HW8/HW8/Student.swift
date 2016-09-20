//
//  Student.swift
//  HW8
//
//  Created by Руслан on 20.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation

class Student: NSObject {
    
    let name: String
    let surname: String
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
    
    func sayHello() -> String {
        return "Hello!"
    }
}