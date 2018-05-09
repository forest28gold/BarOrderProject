//
//  CartData.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

struct CartData {
    
    var objectId: String
    var place: String
    var time: String
    var order: OrderData
    var orderNb: Int
    var hasGlass: Bool
    var glass: GlassData
    
    init(objectId: String, place: String, time: String, order: OrderData, orderNb: Int, hasGlass: Bool, glass: GlassData) {
        
        self.objectId = objectId
        self.place = place
        self.time = time
        self.order = order
        self.orderNb = orderNb
        self.hasGlass = hasGlass
        self.glass = glass
    }
}
