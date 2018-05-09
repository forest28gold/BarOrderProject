//
//  PastOrderDetailsController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class PastOrderDetailsController: Controller, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnLeftMargin: NSLayoutConstraint!
    @IBOutlet weak var btnRightMargin: NSLayoutConstraint!
    
    @IBOutlet var orderTitleLabel: UILabel!
    @IBOutlet var orderDetailsTableView: UITableView!
    
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
            self.btnRightMargin.constant += CGFloat(BUTTON_MARGIN)
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Actions
    
    @IBAction func navbarBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: UITableView Delegate
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsCell", for: indexPath as IndexPath)
        
        let placeLable = cell.viewWithTag(1) as? UILabel
        let timeLable = cell.viewWithTag(2) as? UILabel
        let orderDateTime = cell.viewWithTag(3) as? UILabel
        let orderCode = cell.viewWithTag(4) as? UILabel
        let ordersView = cell.viewWithTag(5)
        let beforeTotalPriceLable = cell.viewWithTag(6) as? UILabel
        let taxesLable = cell.viewWithTag(12) as? UILabel
        let taxePriceLable = cell.viewWithTag(7) as? UILabel
        let subTotalPriceLable = cell.viewWithTag(8) as? UILabel
        let depositView = cell.viewWithTag(9)
        let tipPriceLable = cell.viewWithTag(10) as? UILabel
        let totalPriceLable = cell.viewWithTag(11) as? UILabel
        let tipPercent0 = cell.viewWithTag(12) as? UIButton
        let tipPercent1 = cell.viewWithTag(13) as? UIButton
        let tipPercent2 = cell.viewWithTag(14) as? UIButton
        let tipPercent3 = cell.viewWithTag(15) as? UIButton
        
        orderCode?.attributedText = NSAttributedString(string: "2254", attributes:[ NSAttributedStringKey.kern: 4])
        
        let orderCell = tableView.dequeueReusableCell(withIdentifier: "OrderCell")
        let orderCountView = orderCell?.viewWithTag(2)
        let orderName = orderCell?.viewWithTag(5)
        orderCountView?.layer.cornerRadius = (orderCountView?.frame.size.height)! / 2
        orderName?.isHidden = true
        
        ordersView?.addSubview(orderCell!)
        
        let subOrderCell = tableView.dequeueReusableCell(withIdentifier: "SubOrderCell")
        let subOrderCountView = subOrderCell?.viewWithTag(2)
        subOrderCountView?.layer.cornerRadius = (subOrderCountView?.frame.size.height)! / 2
        
        depositView?.addSubview(subOrderCell!)
        
        tipPercent0?.isEnabled = false
        tipPercent1?.isEnabled = false
        tipPercent2?.isEnabled = false
        tipPercent3?.isEnabled = false
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
