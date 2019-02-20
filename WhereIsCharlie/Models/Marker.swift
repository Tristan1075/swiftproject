//
//  Marker.swift
//  WhereIsCharlie
//
//  Created by Tristan Luong on 20/02/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Foundation
import GoogleMaps

public class Marker: GMSMarker {
    
    var id: Int
    var longitude: Double
    var latitude: Double
        
    init(id: Int, longitude: Double, latitude: Double) {
        self.id = id
        self.longitude = longitude
        self.latitude = latitude

    }
}

