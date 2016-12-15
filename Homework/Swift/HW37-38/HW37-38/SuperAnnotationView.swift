//
//  SuperAnnotationView.swift
//  HW37-38
//
//  Created by Руслан on 15.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation
import MapKit

extension UIView {
    
    func superAnnotationView() -> MKAnnotationView? {
        
        if self is MKAnnotationView {
            return self as? MKAnnotationView
        }
        
        if self.superview == nil {
            return nil
        }
        
        return self.superview?.superAnnotationView()
    }
    
}
