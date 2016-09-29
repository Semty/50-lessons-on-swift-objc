//
//  Student.swift
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Student: Patient {
    
    let surname: String
    
    init(name: String, surname: String) {
        self.surname = surname
        super.init(name: name)
    }

}
