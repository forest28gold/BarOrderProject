//
//  SplashController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/5/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

class SplashController: Controller {
    
    var isViewDisplayed: Bool = false {
        didSet {
            self.showAlertWhenReady()
        }
    }
    
    var popupShouldShow: Bool = false {
        didSet {
            self.showAlertWhenReady()
        }
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initLayout()
        self.initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadNavItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isViewDisplayed = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    /// Load navigation item
    func loadNavItem() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Layout
    
    /// Init any UI Related Content
    func initLayout() {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    // MARK: Data Management
    
    /// Perform initial data loading
    func initData() {
        Queue.userInitiated.async {
            do {
                delay(delay: .seconds(1), {
                    // Do your loading stuff here and throw an error if needed
                    let defaults = UserDefaults.standard
                    if defaults.bool(forKey: "login") {
                        self.goMain()
                    } else if defaults.bool(forKey: "tutorial") {
                        self.goLogin()
                    } else {
                        self.goTutorial()
                    }
                })
            }
        }
    }
    
    func showAlertWhenReady() {
        Queue.main.async {
            if self.isViewDisplayed && self.popupShouldShow {
                let alert = UIAlertController(title: localized("splash_setup_error"), message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: localized("splash_setup_retry"), style: .default, handler: { (_) in
                    self.initData()
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func goTutorial() {
        Queue.main.async {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.performSegue(withIdentifier: Route.routeSplash.to(.routeTutorial), sender: self)
        }
    }
    
    func goLogin() {
        Queue.main.async {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.performSegue(withIdentifier: Route.routeSplash.to(.routeLogin), sender: self)
        }
    }
    
    func goMain() {
        Queue.main.async {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.performSegue(withIdentifier: Route.routeSplash.to(.routeMain), sender: self)
        }
    }
}
