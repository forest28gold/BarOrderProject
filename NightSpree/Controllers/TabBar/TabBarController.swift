//
//  TabBarController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let titles: NSArray = ["Home", "Discount", "Order"]
    let imagesSelected: NSArray = ["tabbarHomeSelected", "tabbarDiscountSelected", "tabbarOrderSelected"]
    let imagesNormal: NSArray = ["tabbarHome", "tabbarDiscount", "tabbarOrder"]
    var controllers: [UIViewController] = []
    var navigationControllers: [NSObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Layout
    
    func loadLayout() {
        Config.tabBarCtrl = self
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTabHome.identifier) as! TabHomeController
        let discountVC = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTabDiscount.identifier) as! TabDiscountController
        let orderVC = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTabOrder.identifier) as! TabOrderController
        
        controllers = [homeVC, discountVC, orderVC]
        
        self.createTabbar()
    }
    
    func createTabbar() {
        for indexCount in 0..<self.controllers.count {
            let navigationController = UINavigationController(rootViewController:self.controllers[indexCount])
//            navigationController.tabBarItem.title = self.titles[indexCount] as? String
//            navigationController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 2)], for: .normal)
            navigationController.navigationBar.isHidden = true
            navigationController.tabBarItem.title = nil
            navigationController.tabBarItem.image = UIImage.init(named: self.imagesNormal[indexCount] as! String)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            navigationController.tabBarItem.selectedImage = UIImage.init(named: self.imagesSelected[indexCount] as! String)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            self.navigationControllers.append(navigationController)
        }
        
        self.viewControllers = (self.navigationControllers as! [UIViewController] as NSArray) as? [UIViewController]
        self.tabBar.backgroundImage = UIImage(named: "tabbarBackground")
        self.tabBar.isTranslucent = false
        let tabBarItemSize = CGSize(width: (self.tabBar.frame.width) / 3, height: (self.tabBar.frame.height))
        self.tabBar.selectionIndicatorImage = UIImage(named: "tabbarIndicator")?.imageResize(sizeChange: tabBarItemSize)
        iPhoneX {
            self.tabBar.selectionIndicatorImage = UIImage(named: "tabbarXIndicator")
            self.tabBar.backgroundImage = UIImage(named: "tabbarXBackground")
        }
        self.selectedIndex = 0
    }
}
