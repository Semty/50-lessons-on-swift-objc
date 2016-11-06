//
//  RandomColor.swift
//  HW30
//
//  Created by Руслан on 06.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class RandomColor: NSObject {
    
    var color = UIColor.black
    var name = "Default"
    
    override init() {
        
        super.init()
        
        let (color, name) = randomColor()
        
        self.color = color
        self.name = name
        
    }
    
    func randomColor() -> (color: UIColor, name: String) {
        
        let r = (CGFloat)(arc4random() % 256) / 255.0
        let g = (CGFloat)(arc4random() % 256) / 255.0
        let b = (CGFloat)(arc4random() % 256) / 255.0
        
        let rgbString = "RGB(\(Int(r * 255)), \(Int(g * 255)), \(Int(b * 255)))"
        
        return (UIColor.init(red: r, green: g, blue: b, alpha: 1.0), rgbString)
    }

}
