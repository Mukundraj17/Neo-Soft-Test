//
//  VenueModel.swift
//  Test
//
//  Created by Mac on 10/03/17.
//  Copyright © 2017 Surya Foundation. All rights reserved.
//

import UIKit

class VenueModel: NSObject {
    var venueName = String()
    var venueAddress = String()
    var venuecrosssStreet = String()
    var venuedistance = Double()
    var venuecity = String()
    var venueState = String()
    init(name : String , address : String , crossSteet : String , distance : Double, City : String , State : String){
        self.venueName = name;
        self.venueAddress = address
        self.venuecrosssStreet = crossSteet
        self.venuedistance = distance
        self.venuecity = City
        self.venueState = State
    }

}
