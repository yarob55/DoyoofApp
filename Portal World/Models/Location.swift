//
//  Location.swift
//  Portal World
//
//  Created by يعرب المصطفى on 8/1/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import Foundation
import ARKit

class Location{
    
    var type : LocationType!
    var dimensions : SCNVector3!
    init(dimensions : SCNVector3, type : LocationType)
    {
        self.dimensions = dimensions
        self.type = type
    }
    
}

enum LocationType : String{
    case Red = "redLocation"
    case Yellow = "yellowLocation"
}
