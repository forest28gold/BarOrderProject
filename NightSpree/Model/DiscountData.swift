//
//  DiscountData.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

struct DiscountData {
    
    var objectId: String
    var category: String
    var categoryImage: String
    var kind: String
    var subkind: String
    var drinkImage: String
    var drinkName: String
    var drinkPrice: String
    var drinkUnit: String
    var nbDrinks: Int
    var hasDeposit: Bool
    var depositImage: String
    var depositName: String
    var depositPrice: String
    var taxes: CGFloat
    var deliveryPlace: String
    var waitingTime: String
    
    init(objectId: String, category: String, categoryImage: String, kind: String, subkind: String,
         drinkImage: String, drinkName: String, drinkPrice: String, drinkUnit: String, nbDrinks: Int,
         hasDeposit: Bool, depositImage: String, depositName: String, depositPrice: String,
         taxes: CGFloat, deliveryPlace: String, waitingTime: String) {
        
        self.objectId = objectId
        self.category = category
        self.categoryImage = categoryImage
        self.kind = kind
        self.subkind = subkind
        self.drinkImage = drinkImage
        self.drinkName = drinkName
        self.drinkPrice = drinkPrice
        self.drinkUnit = drinkUnit
        self.nbDrinks = nbDrinks
        self.hasDeposit = hasDeposit
        self.depositImage = depositImage
        self.depositName = depositName
        self.depositPrice = depositPrice
        self.taxes = taxes
        self.deliveryPlace = deliveryPlace
        self.waitingTime = waitingTime
    }
}
