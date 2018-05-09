//
//  AppDelegate.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/1/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit
import Parse
import Fabric
import Crashlytics
import GRNForceUpdate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        Config.isProd = false
        
        let parseConfiguration = ParseClientConfiguration(block: { (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = Config.Parse.credentials.appId
            ParseMutableClientConfiguration.clientKey = Config.Parse.credentials.masterKey
            ParseMutableClientConfiguration.server = Config.Parse.credentials.url
        })
        Parse.initialize(with: parseConfiguration)
        
        Fabric.with([Crashlytics.self])
        
        DBManager.setUp()
        DBManager.createCartTable()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //self.forceUpdateIfNeeded()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: Application Updates
    
    /** Check if update is necessary */
    func forceUpdateIfNeeded() {
        // You need to fetch these parameters
        
        // Minimum app version needed, should be fetched with a call to the backend. Used for TestFlight or Crashlytics (TF)
        let minVersion: String = "1.0.0"
        // The minimal build number to run the app. used for App Store (AS)
        let buildNumber: String = "1"
        // The environment target
        let environment: String = "TF"
        
        if let window = self.window, let controller = self.window?.rootViewController {
            if (!(controller is GRNDefaultScreenVC) && ForceUpdate.isBuildOutdated(minVersion, buildNumber: buildNumber, environment: environment)) {
                window.rootViewController = ForceUpdate.getViewController("Some url", environment: environment)
                window.makeKeyAndVisible()
            }
        }
    }
}

