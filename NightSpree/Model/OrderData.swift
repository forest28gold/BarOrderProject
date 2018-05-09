//
//  OrderData.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

struct OrderData {
    
    var objectId: String
    var orderImage: String
    var orderName: String
    var orderDesc: String
    var orderPrice: Float
    var orderUnit: String
    var orderTax: Float
    var tipPrice: Float
    var tipPercent: Int
    
    init(objectId: String, orderImage: String, orderName: String, orderDesc: String, orderPrice: Float, orderUnit: String,
         orderTax: Float, tipPrice: Float, tipPercent: Int) {
        
        self.objectId = objectId
        self.orderImage = orderImage
        self.orderName = orderName
        self.orderDesc = orderDesc
        self.orderPrice = orderPrice
        self.orderUnit = orderUnit
        self.orderTax = orderTax
        self.tipPrice = tipPrice
        self.tipPercent = tipPercent
    }
}
