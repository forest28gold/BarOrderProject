//
//  TabOrderController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit
import ICViewPager

class TabOrderController: Controller, ViewPagerDelegate, ViewPagerDataSource {
    
    @IBOutlet var navbarCartButton: UIButton!
    @IBOutlet var navbarCartBadgeView: UIView!
    @IBOutlet var navbarCartBadgeLabel: UILabel!
    
    @IBOutlet weak var currentTabButton: UIButton!
    @IBOutlet weak var currentTabView: UIImageView!
    @IBOutlet weak var pastTabButton: UIButton!
    @IBOutlet weak var pastTabView: UIImageView!
    @IBOutlet weak var tabOrderView: UIView!

    var viewPagerCtrl: ViewPagerController!
    var currentOrdersVC: CurrentOrdersController!
    var pastOrdersVC: PastOrdersController!
    
    var numberOfTabs: UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavCart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Layout
    
    func loadLayout() {
        
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognizer(sender:))))
 
        navbarCartBadgeView.layer.cornerRadius = navbarCartBadgeView.frame.size.height / 2
        
        currrentOrdersSelection()
        
        Config.tabOrderCtrl = self
        
        currentOrdersVC = (self.storyboard?.instantiateViewController(withIdentifier: Route.routeCurrentOrders.identifier))! as! CurrentOrdersController
        pastOrdersVC = (self.storyboard?.instantiateViewController(withIdentifier: Route.routePastOrders.identifier))! as! PastOrdersController
        
        self.viewPagerCtrl = ViewPagerController()
        self.viewPagerCtrl.view.frame = CGRect(x: 0, y: -20, width: self.tabOrderView.frame.size.width, height: self.tabOrderView.frame.size.height + 25)
        self.viewPagerCtrl.delegate = self
        self.viewPagerCtrl.dataSource = self
        self.tabOrderView.addSubview(self.viewPagerCtrl.view)
        
        perform(#selector(self.loadContent), with: nil, afterDelay: 0.0)
    }
    
    // MARK: Show NavCart
    
    func showNavCart() {
        let carts = DBManager.readCart(email: Config.userEmail)
        if carts.count > 0 {
            
            navbarCartBadgeView.isHidden = false
            navbarCartButton.setImage(UIImage(named: "navbarCartActive"), for: .normal)
            
            var totalCount = 0
            
            for cart in carts {
                totalCount = totalCount + cart.nbDrinks
            }
            navbarCartBadgeLabel.text = String(totalCount)
            
        } else {
            navbarCartBadgeView.isHidden = true
            navbarCartBadgeLabel.text = "0"
            navbarCartButton.setImage(UIImage(named: "navbarCart"), for: .normal)
        }
    }
    
    func currrentOrdersSelection() {
        currentTabButton.setTitleColor(UIColor.white, for: .normal)
        currentTabView.image = UIImage(named: "buttonBackground")
        
        pastTabButton.setTitleColor(colorHEX("39383d"), for: .normal)
        pastTabView.image = UIImage(named: "tabBackground")
    }
    
    func pastOrdersSelection() {
        pastTabButton.setTitleColor(UIColor.white, for: .normal)
        pastTabView.image = UIImage(named: "buttonBackground")
        
        currentTabButton.setTitleColor(colorHEX("39383d"), for: .normal)
        currentTabView.image = UIImage(named: "tabBackground")
    }
    
    @objc func panGestureRecognizer(sender: UIPanGestureRecognizer) {
        // Dismiss keyboard (optional)
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        
        // Present the view controller
        self.frostedViewController.panGestureRecognized(sender)
    }
    
    @objc func loadContent() {
        self.numberOfTabs = 2
        self.viewPagerCtrl.reloadData()
    }
    
    // MARK: ViewPager DataSource
    
    func numberOfTabs(forViewPager viewPager: ViewPagerController!) -> UInt {
        return self.numberOfTabs
    }
    
    func viewPager(_ viewPager: ViewPagerController!, viewForTabAt index: UInt) -> UIView! {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.tabOrderView.frame.size.width, height: 0))
        view.backgroundColor = UIColor.clear
        view.isHidden = true
        return view
    }
    
    func viewPager(_ viewPager: ViewPagerController!, contentViewControllerForTabAt index: UInt) -> UIViewController! {
        if index == 0 {
            return currentOrdersVC
        } else {
            return pastOrdersVC
        }
    }
    
    // MARK: ViewPager Delegate
    
    func viewPager(_ viewPager: ViewPagerController!, valueFor option: ViewPagerOption, withDefault value: CGFloat) -> CGFloat {
        return 0.0
    }
    
    func viewPager(_ viewPager: ViewPagerController!, colorFor component: ViewPagerComponent, withDefault color: UIColor!) -> UIColor! {
        return UIColor.clear
    }
    
    func viewPager(_ viewPager: ViewPagerController!, didChangeTabTo index: UInt) {
        if index == 0 {
            currrentOrdersSelection()
        } else {
            pastOrdersSelection()
        }
    }
    
    // MARK: Actions
    
    @IBAction func navbarMenuButtonPressed(_ sender: Any) {
        // Dismiss keyboard (optional)
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        
        // Present the view controller
        self.frostedViewController.presentMenuViewController()
    }
    
    @IBAction func navbarCartButtonPressed(_ sender: Any) {
        Config.isMyCart = true
        Config.mainCtrl?.goMyCart()
    }
    
    @IBAction func currentOrdersButtonPressed(_ sender: Any) {
        currrentOrdersSelection()
        self.viewPagerCtrl.selectTab(at: 0)
    }
    
    @IBAction func pastOrdersButtonPressed(_ sender: Any) {
        pastOrdersSelection()
        self.viewPagerCtrl.selectTab(at: 1)
    }
    
    func goOrderToDrink() {
        Config.tabBarCtrl?.selectedIndex = 0
    }
}
