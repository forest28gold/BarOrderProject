//
//  MenuController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/5/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

class MenuController: Controller, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnLeftMargin: NSLayoutConstraint!
    @IBOutlet weak var btnRightMargin: NSLayoutConstraint!
    
    @IBOutlet var menuTableView: UITableView!
    
    let titles: NSArray = [localized("menu_payment"), localized("menu_help"), localized("menu_settings")]
    let images: NSArray = ["menuCredit", "menuHelp", "menuSettings"]
    
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
        iPhoneX {
            self.btnLeftMargin.constant += CGFloat(BUTTON_MARGIN)
            self.btnRightMargin.constant -= CGFloat(BUTTON_MARGIN)
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Actions
    
    @IBAction func navbarCloseButtonPressed(_ sender: Any) {
        self.frostedViewController.hideMenuViewController()
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.frostedViewController.hideMenuViewController()
        
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "login")
        
        let root = storyboard?.instantiateViewController(withIdentifier: "RootNavigationController") as! UINavigationController
        let loginVC = storyboard?.instantiateViewController(withIdentifier: Route.routeLogin.identifier)
        root.setViewControllers([loginVC!], animated: true)
        UIApplication.shared.keyWindow?.rootViewController = root
    }
    
    // MARK: UITableView Delegate
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath as IndexPath)
        
        let menuImage = cell.viewWithTag(1) as? UIImageView
        let menuLable = cell.viewWithTag(2) as? UILabel

        menuImage?.image = UIImage(named: images[indexPath.row] as! String)
        menuLable?.text = titles[indexPath.row] as? String

        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        self.frostedViewController.hideMenuViewController()
        
        if indexPath.row == 0 {
            Config.mainCtrl?.goCreditCard()
        } else if indexPath.row == 1 {
            Config.mainCtrl?.goHelp()
        } else {
            Config.mainCtrl?.goSettings()
        }
    }
}
