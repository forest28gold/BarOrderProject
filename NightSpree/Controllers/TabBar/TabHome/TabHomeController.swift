//
//  TabHomeController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit
import Parse

class TabHomeController: Controller, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet var navbarCartButton: UIButton!
    @IBOutlet var navbarCartBadgeView: UIView!
    @IBOutlet var navbarCartBadgeLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadLayout()
        self.initLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swipeToPop()
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
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMMM"
        dateLabel.text = formatter.string(from: date as Date).uppercased()
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
    
    // MARK: Load Data
    
    func initLoadData() {
        
        Config.barArray.removeAll()
        
        self.showLoading(status: localized("generic_wait"))
        
        let query = PFQuery(className: Const.ParseClass.BarClass)
        query.whereKey("isEnabled", equalTo:true)
        query.findObjectsInBackground (block: { (objects, error) in
            
            self.stopLoading()
            
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        Config.barArray.append(object)
                    }
                    self.homeTableView.reloadData()
                }
            } else {
                
            }
        })
    }
    
    // MARK: Navigation Menu Swipe Gesture
    
    @objc func panGestureRecognizer(sender: UIPanGestureRecognizer) {
        // Dismiss keyboard (optional)
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        
        // Present the view controller
        self.frostedViewController.panGestureRecognized(sender)
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
    
    // MARK: UITableView Delegate
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.barArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 169
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BarCell", for: indexPath as IndexPath)
        
        let barImage = cell.viewWithTag(1) as? UIImageView
        let barNameLable = cell.viewWithTag(2) as? UILabel
        let timeStampLable = cell.viewWithTag(3) as? UILabel
        
        let barData = Config.barArray[indexPath.row]
        
        let name = Config.onCheckStringNull(object: barData, key: "name")
        let image = Config.onCheckFileNull(object: barData, key: "image")
        let orderMinutes = Config.onCheckNumberNull(object: barData, key: "orderMinutes")

        barImage?.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "barPlaceholder"))
        barNameLable?.text = name
        timeStampLable?.text = String(orderMinutes) + " " + localized("home_minutes")
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        Config.barObject = Config.barArray[indexPath.row]
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeTabHome.to(.routeDrinkList), sender: self)
    }
}
