//
//  DrinkData.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/18/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit
import Parse

struct DrinkData {
    
    var drinkObject: PFObject
    var nbDrinks: Int
    var price: Float
    var glassObject: PFObject?
    var barObject: PFObject
    var categoryObject: PFObject
    var subcategoryObject: PFObject
    var isSubcategory: Bool
    
    init(drinkObject: PFObject, nbDrinks: Int, price: Float, glassObject: PFObject?, barObject: PFObject, categoryObject: PFObject, subcategoryObject: PFObject, isSubcategory: Bool) {
        
        self.drinkObject = drinkObject
        self.nbDrinks = nbDrinks
        self.price = price
        self.glassObject = glassObject
        self.barObject = barObject
        self.categoryObject = categoryObject
        self.subcategoryObject = subcategoryObject
        self.isSubcategory = isSubcategory
    }
}
