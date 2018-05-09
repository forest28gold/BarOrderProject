//
//  MainController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/1/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit
import REFrostedViewController

class MainController: REFrostedViewController, UIGestureRecognizerDelegate {
    
    override func awakeFromNib() {
        self.contentViewController = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTabBar.identifier)
        self.menuViewController = self.storyboard?.instantiateViewController(withIdentifier: Route.routeMenu.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swipeToPop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Layout
    
    func loadLayout() {
        Config.mainCtrl = self
        self.menuViewSize = self.view.frame.size
        self.view.layoutIfNeeded()
    }
    
    // MARK: Navigation Back Swipe Gesture
    
    func swipeToPop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return true
        }
        return false
    }
    
    // MARK: Navigation
    
    func goCreditCard() {
        Config.isEditCreditCard = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeMain.to(.routeCreditCard), sender: self)
    }
    
    func goMyCart() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeMain.to(.routeMyCart), sender: self)
    }
    
    func goCurrentOrderDetails() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeMain.to(.routeCurrentOrderDetails), sender: self)
    }
    
    func goPastOrderDetails() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeMain.to(.routePastOrderDetails), sender: self)
    }
    
    func goHelp() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeMain.to(.routeHelp), sender: self)
    }
    
    func goSettings() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeMain.to(.routeSettings), sender: self)
    }
    
    // MARK: Unwind Navigation
    
    @IBAction func unwindSuccessOrderToTabHome(segue: UIStoryboardSegue) {
        Config.tabBarCtrl?.selectedIndex = 0
        Config.drinkListCtrl?.navigationBack()
        Config.discountBarCtrl?.navigationBack()
    }
    
    @IBAction func unwindSuccessOrderToTabOrder(segue: UIStoryboardSegue) {
        Config.tabBarCtrl?.selectedIndex = 2
        Config.drinkListCtrl?.navigationBack()
        Config.discountBarCtrl?.navigationBack()
        Config.tabOrderCtrl?.currrentOrdersSelection()
        Config.tabOrderCtrl?.viewPagerCtrl.selectTab(at: 0)
    }
    
    @IBAction func unwindMyCartToTabHome(segue: UIStoryboardSegue) {
        Config.tabBarCtrl?.selectedIndex = 0
        Config.drinkListCtrl?.navigationBack()
        Config.discountBarCtrl?.navigationBack()
    }
}

