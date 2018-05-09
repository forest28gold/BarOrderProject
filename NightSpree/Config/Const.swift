//
//  Const.swift
//
//  Created by Benjamin Bourasseau on 19/01/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation
import UIKit

let BUTTON_MARGIN = 20

struct Const {
    
    // MARK: Database Class names
    
    struct Database {
        static let SampleTable = "Night*****"
    }
    
    // MARK: User default Keys
    
    struct UserDefaults {
        static var launchedOnce: String {
            return "\(bundleId).launchedOnce"
        }
    }
    
    // MARK: Height and Width
    
    struct Size {
        static let NavBarHeight: CGFloat = 64.0
    }
    
    // MARK: Custom objects
    
    struct NavButtons {
        static let close = NavButton(image: #imageLiteral(resourceName: "navbarClose"), size: CGSize(width: 21.0, height: 20.0))
    }
    
    struct Url {
        private static let appStoreLink = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews"
        static let appStoreRating = "\(appStoreLink)?id=\(Config.App.appStoreId)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
        static let appStoreDownload = "itms-apps://itunes.apple.com/app/x-gift/id\(Config.App.appStoreId)?mt=8&uo=4"
    }
    
    struct Colors {
        
    }
    
    struct ParseClass {
        static let BarClass = "B==="
        static let DiscountClass = "D====="
        static let DiscountDrinkClass = "D======"
        static let DrinkClass = "D====="
        static let DrinkCategoryClass = "D======="
        static let DrinkSubcategoryClass = "D======="
        static let GlassClass = "G====="
        static let HelpClass = "H======"
        static let ItemOrderClass = "I====="
        static let NotificationClass = "N====="
        static let OrderClass = "O====="
        static let PromotionClass = "P======"
    }
    
}

struct Fonts {
    enum HelveticaNeue: String {
        case light = "Light"
        
        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue-\(self.rawValue)", size: size)!
        }
    }
}

// MARK: AppDelegate

let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
