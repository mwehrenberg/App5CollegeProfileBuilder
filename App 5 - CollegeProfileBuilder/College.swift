//
//  College.swift
//  App 5 - CollegeProfileBuilder
//
//  Created by John Wehrenberg on 7/3/17.
//  Copyright © 2017 Molly Wehrenberg. All rights reserved.
//

import UIKit
import RealmSwift

class College: Object {
    dynamic var name = String()
    dynamic var location = String()
    dynamic var enrollment = Int()
    dynamic var image = Data()
    
    convenience init(name : String, location : String, enrollment : Int, image : Data) {
        self.init()
        self.name = name
        self.location = location
        self.enrollment = enrollment
        self.image = image
    }
}
