//
//  Kangaroo.swift
//  HW7
//
//  Created by Руслан on 19.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation

class Kangaroo: Runners, Jumpers {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func run() -> String {
        return "Kangaroo \(self.name) is running"
    }
    
    func jump() -> String {
        return "Kangaroo \(self.name) is jumping"
    }
    
    func laugh() -> String {
        return "Kangaroo \(self.name) doesn't laugh"
    }


}
