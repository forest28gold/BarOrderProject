//
//  SuccessOrderController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class SuccessOrderController: Controller, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btn1LeftMargin: NSLayoutConstraint!
    @IBOutlet weak var btn1RightMargin: NSLayoutConstraint!
    @IBOutlet weak var btn2LeftMargin: NSLayoutConstraint!
    @IBOutlet weak var btn2RightMargin: NSLayoutConstraint!
    @IBOutlet weak var btnBottomMargin: NSLayoutConstraint!
    
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
        
        iPhoneX {
            self.btn1LeftMargin.constant += CGFloat(BUTTON_MARGIN)
            self.btn1RightMargin.constant -= CGFloat(BUTTON_MARGIN)
            self.btn2LeftMargin.constant += CGFloat(BUTTON_MARGIN)
            self.btn2RightMargin.constant -= CGFloat(BUTTON_MARGIN)
            self.btnBottomMargin.constant += CGFloat(BUTTON_MARGIN) / 2
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Navigation Back Swipe Gesture
    
    func swipeToPop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: Actions
    
    @IBAction func returnHomeButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: Route.routeSuccessOrder.unwind(.routeTabHome), sender: self)
    }
    
    @IBAction func returnOrderButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: Route.routeSuccessOrder.unwind(.routeTabOrder), sender: self)
    }
    
    // MARK: UITableView Delegate
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.successArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuccessCell", for: indexPath as IndexPath)
        
        let barNameTimeLabel = cell.viewWithTag(1) as? UILabel
        let orderCodeLabel = cell.viewWithTag(2) as? UILabel
        let waitingTimeLabel = cell.viewWithTag(3) as? UILabel
        let progressLabel = cell.viewWithTag(4) as? UILabel
        let readyLabel = cell.viewWithTag(5) as? UILabel
        let progressImage = cell.viewWithTag(6) as? UIImageView
        let readyImage = cell.viewWithTag(7) as? UIImageView
        let codeLabel = cell.viewWithTag(8) as? UILabel
        let timeLabel = cell.viewWithTag(9) as? UILabel
        let timeImage = cell.viewWithTag(10) as? UIImageView
        
        codeLabel?.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: (codeLabel?.frame)!, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        timeLabel?.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: (timeLabel?.frame)!, colors: [colorHEX("22096d"), colorHEX("b178d0")])

        let successData = Config.successArray[indexPath.row]
        
        barNameTimeLabel?.text = localized("success_congratulations") + "\n" + localized("success_about") + " " + successData.barTime + " " + localized("success_at") + " " + successData.barName
        orderCodeLabel?.attributedText = NSAttributedString(string: successData.orderCode, attributes:[ NSAttributedStringKey.kern: 5])
        waitingTimeLabel?.attributedText = NSAttributedString(string: successData.waitingTime, attributes:[ NSAttributedStringKey.kern: 5])
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let today = formatter.string(from: date as Date)
        
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "dd/MM/yyyy HH:mm"
        let orderTime = formatterTime.date(from: today + " " + successData.waitingTime)
        
        if orderTime! <= (date as Date) {
            timeImage?.image = UIImage(named: "readyTime")
            waitingTimeLabel?.textColor = colorHEX("4ed964")
            progressLabel?.textColor = colorHEX("808187")
            readyLabel?.textColor = colorHEX("4ed964")
            progressLabel?.text = localized("success_progress")
            readyLabel?.text = localized("success_lets_go")
            progressImage?.image = UIImage(named: "orderUnreadyBackground")
            readyImage?.image = UIImage(named: "orderReadyBackground")
        } else {
            timeImage?.image = UIImage(named: "orderTime")
            waitingTimeLabel?.textColor = UIColor.white
            progressLabel?.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: (progressLabel?.frame)!, colors: [colorHEX("22096d"), colorHEX("b178d0")])
            readyLabel?.textColor = colorHEX("808187")
            progressLabel?.text = localized("success_progress")
            readyLabel?.text = localized("success_ready")
            progressImage?.image = UIImage(named: "buttonBackground")
            readyImage?.image = UIImage(named: "orderUnreadyBackground")
        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
