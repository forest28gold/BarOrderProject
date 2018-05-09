//
//  ViewController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/1/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class ViewController: Controller {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadNavbar()
        self.loadLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    func loadNavbar() {
        /* You can set your custom navigation bar here */
        self.navItem = NavItem(title: "Home Controller", controller: self)
        self.navItem?.delegate = self
        self.navItem?.setBack()
        // self.navItem?.navItemStyle = .orange
        self.navItem?.setClose(.right)
        self.navItem?.update()
    }
    
    func navItemDidTapBack() {
        self.showSuccess(success: "Back button tapped")
    }
    
    func navItemDidTapRightButton() {
        self.showSuccess(success: "Close button tapped")
    }
    
    // MARK: Layout
    
    func loadLayout() {
        
    }

}

