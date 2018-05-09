//
//  SuccessData.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/21/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

struct SuccessData {
    
    var barName: String
    var barTime: String
    var orderCode: String
    var waitingTime: String
    
    init(barName: String, barTime: String, orderCode: String, waitingTime: String) {
        
        self.barName = barName
        self.barTime = barTime
        self.orderCode = orderCode
        self.waitingTime = waitingTime
    }
}
