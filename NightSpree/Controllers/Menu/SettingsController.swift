//
//  SettingsController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class SettingsController: Controller {
    
    @IBOutlet var orderReadySwitch: UIButton!
    @IBOutlet var nearbySwitch: UIButton!
    
    var isOrderReady = true
    var isNearby = true
    
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
        orderReadySwitch.setImage(UIImage(named: "switchOn"), for: .normal)
        nearbySwitch.setImage(UIImage(named: "switchOn"), for: .normal)
    }
    
    // MARK: Actions
    
    @IBAction func navbarBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func orderReadySwitchPressed(_ sender: Any) {
        if isOrderReady {
            isOrderReady = false
            orderReadySwitch.setImage(UIImage(named: "switchOff"), for: .normal)
        } else {
            isOrderReady = true
            orderReadySwitch.setImage(UIImage(named: "switchOn"), for: .normal)
        }
    }
    
    @IBAction func nearbySwitchPressed(_ sender: Any) {
        if isNearby {
            isNearby = false
            nearbySwitch.setImage(UIImage(named: "switchOff"), for: .normal)
        } else {
            isNearby = true
            nearbySwitch.setImage(UIImage(named: "switchOn"), for: .normal)
        }
    }
}

