//
//  Jumper.swift
//  HW7
//
//  Created by Руслан on 19.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation

class Jumper: Jumpers {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func jump() -> String {
        return "Jumper \(self.name) is jumping"
    }
    
    func laugh() -> String {
        return "Jumper \(self.name) is laughing"
    }


}
