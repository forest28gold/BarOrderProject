//
//  DiscountBarController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class DiscountBarController: Controller, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var navbarCartButton: UIButton!
    @IBOutlet var navbarCartBadgeView: UIView!
    @IBOutlet var navbarCartBadgeLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var discountBarTableView: UITableView!
    
    var kinds = [String]()
    var drinks = [[DiscountData]]()
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadLayout()
        self.initLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavCart()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.showCurrentDateTime), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Layout
    
    func loadLayout() {
        Config.discountBarCtrl = self

        navbarCartBadgeView.layer.cornerRadius = navbarCartBadgeView.frame.size.height / 2
        
        showCurrentDateTime()
    }
    
    @objc func showCurrentDateTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, HH:mm"
        let today = formatter.string(from: date as Date)
        dateLabel.text = today.replacingOccurrences(of: ":", with: "H")
    }
    
    // MARK: Show NavCart
    
    func showNavCart() {
        let carts = DBManager.readCart(email: Config.userEmail)
        if carts.count > 0 {
            
            navbarCartBadgeView.isHidden = false
            navbarCartButton.setImage(UIImage(named: "navbarCartActive"), for: .normal)
            
            var totalCount = 0
            
            for cart in carts {
                totalCount = totalCount + cart.nbDrinks
            }
            navbarCartBadgeLabel.text = String(totalCount)
            
        } else {
            navbarCartBadgeView.isHidden = true
            navbarCartBadgeLabel.text = "0"
            navbarCartButton.setImage(UIImage(named: "navbarCart"), for: .normal)
        }
    }
    
    func initLoadData() {
        
        kinds = ["Sapporo Cans at $ 8 between 5pm and 7pm", "20% on all day sapporo"]
        
        let drinkData1 = DiscountData.init(objectId: "", category: "", categoryImage: "", kind: kinds[0], subkind: "",
                                        drinkImage: "", drinkName: "Sapporo", drinkPrice: "10.00 $", drinkUnit: "650 ml", nbDrinks: 0,
                                        hasDeposit: false, depositImage: "", depositName: "", depositPrice: "",
                                        taxes: 14.975, deliveryPlace: "BAR SAPPORO", waitingTime: "8 minutes")
        let drinkData2 = DiscountData.init(objectId: "", category: "", categoryImage: "", kind: kinds[0], subkind: "",
                                        drinkImage: "", drinkName: "Pabst Blue Ribbon", drinkPrice: "8.00 $", drinkUnit: "473 ml", nbDrinks: 0,
                                        hasDeposit: false, depositImage: "", depositName: "", depositPrice: "",
                                        taxes: 14.975, deliveryPlace: "BAR SAPPORO", waitingTime: "8 minutes")
        let drinkData3 = DiscountData.init(objectId: "", category: "", categoryImage: "", kind: kinds[0], subkind: "",
                                        drinkImage: "", drinkName: "Mystique", drinkPrice: "6.50 $", drinkUnit: "", nbDrinks: 1,
                                        hasDeposit: false, depositImage: "", depositName: "", depositPrice: "",
                                        taxes: 14.975, deliveryPlace: "BAR SAPPORO", waitingTime: "8 minutes")
        let drinkData4 = DiscountData.init(objectId: "", category: "", categoryImage: "", kind: kinds[0], subkind: "",
                                        drinkImage: "", drinkName: "Mystique rose", drinkPrice: "6.50 $", drinkUnit: "", nbDrinks: 2,
                                        hasDeposit: false, depositImage: "", depositName: "", depositPrice: "",
                                        taxes: 14.975, deliveryPlace: "BAR SAPPORO", waitingTime: "8 minutes")
        
        let drinkData5 = DiscountData.init(objectId: "", category: "", categoryImage: "", kind: kinds[1], subkind: "",
                                        drinkImage: "", drinkName: "Verre de Sapporo", drinkPrice: "5.00 $", drinkUnit: "330 ml", nbDrinks: 2,
                                        hasDeposit: true, depositImage: "", depositName: "Verre recyclable (rembourable)", depositPrice: "2.00 $ CA / unite (consigne)",
                                        taxes: 14.975, deliveryPlace: "BAR SAPPORO", waitingTime: "8 minutes")
        let drinkData6 = DiscountData.init(objectId: "", category: "", categoryImage: "", kind: kinds[1], subkind: "",
                                        drinkImage: "", drinkName: "Pinte de Sapporo", drinkPrice: "7.00 $", drinkUnit: "500 ml", nbDrinks: 0,
                                        hasDeposit: true, depositImage: "", depositName: "Verre recyclable (rembourable)", depositPrice: "2.00 $ CA / unite (consigne)",
                                        taxes: 14.975, deliveryPlace: "BAR SAPPORO", waitingTime: "8 minutes")
        
        drinks = [[drinkData1, drinkData2, drinkData3, drinkData4], [drinkData5, drinkData6]]
        
        discountBarTableView.reloadData()
    }
    
    // MARK: Actions
    
    @IBAction func navbarBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigationBack() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func navbarCartButtonPressed(_ sender: Any) {
        Config.isMyCart = true
        Config.mainCtrl?.goMyCart()
    }
    
    // MARK: UITableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.kinds.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.kinds[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 27
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KindCell")
        
        let kindLable = cell?.viewWithTag(1) as? UILabel
        kindLable?.text = self.kinds[section]
        
        return cell
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drinks[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath as IndexPath)
        
        let drinkImage = cell.viewWithTag(1) as? UIImageView
        let countView = cell.viewWithTag(2)
        let countLable = cell.viewWithTag(3) as? UILabel
        let drinkNameLable = cell.viewWithTag(4) as? UILabel
        let nameLable = cell.viewWithTag(5) as? UILabel
        let drinkQuantityLable = cell.viewWithTag(6) as? UILabel
        let oldPriceLable = cell.viewWithTag(7) as? UILabel
        let newPriceLable = cell.viewWithTag(9) as? UILabel
        let addButton = cell.viewWithTag(8) as? UIButton
        
        countView?.layer.cornerRadius = (countView?.frame.size.height)! / 2
        
        let drinkData = self.drinks[indexPath.section][indexPath.row]
        
        if drinkData.nbDrinks == 0 {
            countView?.isHidden = true
        } else {
            countView?.isHidden = false
            countLable?.text = String(drinkData.nbDrinks)
        }
        
        drinkImage?.sd_setImage(with: URL(string: drinkData.drinkImage), placeholderImage: UIImage(named: "drinkPlaceholder"))
        
        if drinkData.drinkUnit == "" {
            drinkNameLable?.isHidden = true
            drinkQuantityLable?.isHidden = true
            nameLable?.isHidden = false
            nameLable?.text = drinkData.drinkName
        } else {
            drinkNameLable?.isHidden = false
            drinkQuantityLable?.isHidden = false
            nameLable?.isHidden = true
            drinkNameLable?.text = drinkData.drinkName
            drinkQuantityLable?.text = drinkData.drinkUnit
        }
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "10.00 $")
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedStringKey.strikethroughColor, value: colorHEX("8a5bb1"), range: NSMakeRange(0, attributeString.length))
        
        oldPriceLable?.attributedText = attributeString
        
//        priceLable?.text = drinkData.drinkPrice
//        addButton?.addTarget(self, action: #selector(self.addButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
