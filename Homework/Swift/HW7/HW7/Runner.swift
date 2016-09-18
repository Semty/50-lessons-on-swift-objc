//
//  Runner.swift
//  HW7
//
//  Created by Руслан on 19.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation

class Runner: Runners {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func run() -> String {
        return "Runner \(self.name) is running"
    }
    
    func laugh() -> String {
        return "Runner \(self.name) is laughing"
    }

}
