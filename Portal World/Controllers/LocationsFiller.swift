//
//  LocationFillers.swift
//  Portal World
//
//  Created by يعرب المصطفى on 8/1/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import Foundation
import UIKit
import ARKit
class LocationsFiller
{
    static func addLocations() -> [Location]
    {
        var locations = [Location]()
        let x:Double = 0
        let y:Double = 0
        
        //creating new location
        let location = Location(dimensions: SCNVector3(x, y, -0.4), type: .Red)
//        let location2 = Location(dimensions: SCNVector3(0.01, y, -7), type: .Yellow)
//        let location3 = Location(dimensions: SCNVector3(0.12, y, -2), type: .Yellow)
//        let location4 = Location(dimensions: SCNVector3(-0.21, y, -20), type: .Yellow)
//        let location5 = Location(dimensions: SCNVector3(-0.43, y, -4), type: .Yellow)
        
        locations.append(location)
//        locations.append(location2)
//        locations.append(location3)
//        locations.append(location4)
//        locations.append(location5)
        return locations
    }
    
    
   

}
