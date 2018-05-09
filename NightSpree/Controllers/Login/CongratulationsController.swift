//
//  CongratulationsController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class CongratulationsController: Controller {
    
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

    }
    
    // MARK: Navigation Back Swipe Gesture
    
    func swipeToPop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: Actions
    
    @IBAction func letsGoButtonPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "login")
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeCongratulations.to(.routeMain), sender: self)
    }
}
