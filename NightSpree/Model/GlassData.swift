//
//  GlassData.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

struct GlassData {
    
    var objectId: String
    var glassImage: String
    var glassName: String
    var glassPrice: Float
    var glassUnit: String
    var glassNb: Int
    
    init(objectId: String, glassImage: String, glassName: String, glassPrice: Float, glassUnit: String, glassNb: Int) {
        
        self.objectId = objectId
        self.glassImage = glassImage
        self.glassName = glassName
        self.glassPrice = glassPrice
        self.glassUnit = glassUnit
        self.glassNb = glassNb
    }
}
