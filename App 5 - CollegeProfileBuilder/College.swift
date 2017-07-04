//
//  College.swift
//  App 5 - CollegeProfileBuilder
//
//  Created by John Wehrenberg on 7/3/17.
//  Copyright © 2017 Molly Wehrenberg. All rights reserved.
//

import UIKit

class College: NSObject {
    var name = String()
    var location = String()
    var enrollment = Double()
    var image = Data()
    
    convenience init(name : String, location : String, enrollment : Double, image : Data) {
        self.init()
        self.name = name
        self.location = location
        self.enrollment = enrollment
        self.image = image
    }
}
