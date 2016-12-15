//
//  MeetingPoint.swift
//  HW37-38
//
//  Created by Руслан on 15.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit
import MapKit

class MeetingPoint: NSObject, MKAnnotation {
    
// MARK: - Public Variables
    
    var coordinate:     CLLocationCoordinate2D
    let title:          String?
    
// MARK: - Private variables
    
    private var longitude: CLLocationDegrees!
    private var latitude: CLLocationDegrees!
    
// MARK: - Initialization
    
    override init() {
        
        var plusOrMinus: Double = arc4random() % 2 == 0 ? -1 : 1
        self.longitude = ((Double)(arc4random() % 5000) / 100000 * plusOrMinus) + Student.mainLongitude
        plusOrMinus = arc4random() % 2 == 0 ? -1 : 1
        self.latitude = ((Double)(arc4random() % 5000) / 100000 * plusOrMinus) + Student.mainLatitude
        
        let tempCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.coordinate = tempCoordinate
        
        self.title = "Meeting"
    }

}
