//
//  TutorialController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/5/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class TutorialController: PagerController, PagerDataSource {
    
    var titles: [String] = []

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
        self.dataSource = self
        
        Config.tutorialCtrl = self
        
        // Instantiating Storyboard ViewControllers
        let controller1 = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTutorial1.identifier)
        let controller2 = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTutorial2.identifier)
        let controller3 = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTutorial3.identifier)
        let controller4 = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTutorial4.identifier)
        let controller5 = self.storyboard?.instantiateViewController(withIdentifier: Route.routeTutorial5.identifier)
        
        // Setting up the PagerController with Name of the Tabs and their respective ViewControllers
        self.setupPager(
            tabNames: ["Tutorial1", "Tutorial2", "Tutorial3", "Tutorial4", "Tutorial5"],
            tabControllers: [controller1!, controller2!, controller3!, controller4!, controller5!])
        
        customizeTab()
    }

    // Customising the Tab's View
    func customizeTab() {
        indicatorColor = UIColor.black
        tabsViewBackgroundColor = UIColor.black
        contentViewBackgroundColor = UIColor.black
        
        startFromSecondTab = false
        centerCurrentTab = true
        tabLocation = PagerTabLocation.top
        tabHeight = 0 // 49
        tabOffset = 36
        tabWidth = 96.0
        fixFormerTabsPositions = false
        fixLaterTabsPosition = false
        animation = PagerAnimation.during
        selectedTabTextColor = .blue
        tabsTextFont = UIFont(name: "HelveticaNeue-Bold", size: 20)!
        tabsTextColor = .white
    }

    func goLogin() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "tutorial")
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeTutorial.to(.routeLogin), sender: self)
    }
}
