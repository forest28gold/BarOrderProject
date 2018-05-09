//
//  Config.swift
//  NightSpree
//
//  Created by Benjamin Bourasseau on 19/01/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation
import Parse

struct Config {
    
    static var isProd = false
    
    struct Parse {
        private static let appId = "ni=================================="
        private static let masterKey = "n====================================="
        private static let url = "https://n==================================="
        private static let devAppId = "n==================================="
        private static let devMasterKey = "n==================================="
        private static let devUrl = "https://n==================================="
        
        /** Return Credentials according to isProd value */
        static var credentials: (appId: String, masterKey: String, url: String) {
            if isProd {
                return (appId:Parse.appId, masterKey: Parse.masterKey, url: Parse.url)
            } else {
                return (appId:Parse.devAppId, masterKey: Parse.devMasterKey, url: Parse.devUrl)
            }
        }
    }
    
    struct App {
     
        /** Identifier on iTunes connect. Used for Rate the App URL */
        static let appStoreId = ""
        
        static let identifier = bundleId
    }
    
    static var tutorialCtrl: TutorialController? = nil
    static var mainCtrl: MainController? = nil
    static var tabBarCtrl: TabBarController? = nil
    static var tabOrderCtrl: TabOrderController? = nil
    static var drinkListCtrl: DrinkListController? = nil
    static var discountBarCtrl: DiscountBarController? = nil
    static var isEditCreditCard = false
    static var isMyCart = false
    
    static var barArray = [PFObject]()
    static var barObject: PFObject!
    static var drinkCartArray = [DrinkData]()
    static var successArray = [SuccessData]()
    
    static var userEmail = "t====="
    
    static public func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    static public func onCheckStringNull(object: PFObject, key: String) -> String {
        let value = object[key] as? String
        if value == nil {
            return ""
        } else {
            return value!
        }
    }
    
    static public func onCheckNumberNull(object: PFObject, key: String) -> Int {
        let value = object[key] as? NSNumber
        if value == nil {
            return 0
        } else {
            return (value?.intValue)!
        }
    }
    
    static public func onCheckFileNull(object: PFObject, key: String) -> String {
        let value = object[key] as? PFFile
        if value == nil {
            return ""
        } else {
            return (value?.url)!
        }
    }
    
    static public func randomString(length: Int) -> String {
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    static public func randomNumber(length: Int) -> String {
        let letters : NSString = "0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}
