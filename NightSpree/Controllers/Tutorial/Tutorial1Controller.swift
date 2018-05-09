//
//  Tutorial1Controller.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/5/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

class Tutorial1Controller: Controller {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
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
        loginButton.setTitleColor(UIColor.fromGradientWithDirection(.leftToRight, frame: loginButton.frame, colors: [colorHEX("cb75fa"), colorHEX("5a3ead")]), for: .normal)
        startButton.setTitleColor(UIColor.fromGradientWithDirection(.leftToRight, frame: startButton.frame, colors: [colorHEX("2d176e"), colorHEX("cb75fa")]), for: .normal)
    }
    
    // MARK: Actions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        Config.tutorialCtrl?.goLogin()
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        Config.tutorialCtrl?.selectTabAtIndex(1, swipe: true)
    }
    
}
