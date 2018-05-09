//
//  Tutorial2Controller.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/5/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

class Tutorial2Controller: Controller {
    
    @IBOutlet var nextButton: UIButton!
    
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
        nextButton.setTitleColor(UIColor.fromGradientWithDirection(.leftToRight, frame: nextButton.frame, colors: [colorHEX("19084c"), colorHEX("cb75fa")]), for: .normal)
    }
    
    // MARK: Actions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        Config.tutorialCtrl?.goLogin()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        Config.tutorialCtrl?.selectTabAtIndex(2, swipe: true)
    }
    
}
