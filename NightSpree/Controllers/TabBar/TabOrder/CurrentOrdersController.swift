//
//  CurrentOrdersController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class CurrentOrdersController: Controller, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet var orderView: UIView!

    @IBOutlet var currentOrdersTableView: UITableView!
    
    var isLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Layout
    
    func loadLayout() {
        
        if isLoad {
            emptyView.isHidden = true
            orderView.isHidden = false
        } else {
            emptyView.isHidden = false
            orderView.isHidden = true
        }
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.isLoad = true
        }
    }
    
    // MARK: Actions
    
    @IBAction func emptyButtonPressed(_ sender: Any) {
        Config.tabOrderCtrl?.goOrderToDrink()
    }
    
    // MARK: UITableView Delegate
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentOrderCell", for: indexPath as IndexPath)
        
        let orderStatus = cell.viewWithTag(1) as? UILabel
        let viewDetailsButton = cell.viewWithTag(2) as? UIButton
        let orderPlace = cell.viewWithTag(3) as? UILabel
        let waitingTime = cell.viewWithTag(4) as? UILabel
        let progressLabel = cell.viewWithTag(5) as? UILabel
        let progressImage = cell.viewWithTag(6) as? UIImageView
        let readyLabel = cell.viewWithTag(7) as? UILabel
        let readyImage = cell.viewWithTag(8) as? UIImageView
        let orderDateTime = cell.viewWithTag(9) as? UILabel
        let orderCode = cell.viewWithTag(10) as? UILabel
        let totalPrice = cell.viewWithTag(12) as? UILabel
        let orderCountView = cell.viewWithTag(13)
        let orderCountLabel = cell.viewWithTag(14) as? UILabel
        let orderName = cell.viewWithTag(15) as? UILabel
        
        orderCountView?.layer.cornerRadius = (orderCountView?.frame.size.height)! / 2
        
        orderCode?.attributedText = NSAttributedString(string: "2254", attributes:[ NSAttributedStringKey.kern: 3])
        
        viewDetailsButton?.layer.borderColor = UIColor.white.cgColor
        viewDetailsButton?.layer.borderWidth = 1.0
        viewDetailsButton?.addTarget(self, action: #selector(self.viewDetailsButtonClicked), for: .touchUpInside)

        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    //------------------------
    
    @objc func viewDetailsButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: currentOrdersTableView)
        let indexPath: IndexPath? = currentOrdersTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
        
        Config.mainCtrl?.goCurrentOrderDetails()
    }
}
