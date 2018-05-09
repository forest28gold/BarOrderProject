//
//  MyCartController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class MyCartController: Controller, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnLeftMargin: NSLayoutConstraint!
    @IBOutlet weak var btnRightMargin: NSLayoutConstraint!
    
    @IBOutlet var cardImage: UIImageView!
    @IBOutlet var cardNumberLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var cartTotalPriceLabel: UILabel!
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet var cartView: UIView!
    
    @IBOutlet var cartTableView: UITableView!

    var cartArray = [CartData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadLayout()
        self.initLoadCartData()
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
        
        editButton.semanticContentAttribute = .forceRightToLeft
    }
    
    // MARK: Load CartData
    
    func initLoadCartData() {
        
        if Config.isMyCart {
            let carts = DBManager.readCart(email: Config.userEmail)
            if carts.count > 0 {
                emptyView.isHidden = true
                cartView.isHidden = false
                
                for cart in carts {
                    
                    let orderData = OrderData.init(objectId: cart.drinkObjectId, orderImage: cart.drinkImage, orderName: cart.drinkName, orderDesc: cart.drinkDesc, orderPrice: Float(cart.drinkUnitPrice)!, orderUnit: cart.drinkUnit, orderTax: Float(cart.drinkTaxes)!, tipPrice: 0, tipPercent: 15)
                    
                    var glassData: GlassData
                    
                    if cart.hasGlass {
                        glassData = GlassData.init(objectId: cart.glassObjectId, glassImage: cart.glassImage, glassName: cart.glassName, glassPrice: Float(cart.glassUnitPrice)!, glassUnit: cart.glassUnit, glassNb: 0)
                    } else {
                        glassData = GlassData.init(objectId: "", glassImage: "", glassName: "", glassPrice: 0.00, glassUnit: "", glassNb: 0)
                    }
                    
                    let cartData = CartData.init(objectId: cart.barObjectId, place: cart.barName, time: String(cart.barTime), order: orderData, orderNb: cart.nbDrinks, hasGlass: cart.hasGlass, glass: glassData)
                    
                    cartArray.append(cartData)
                }
                
                calculateTotalCartPrice()
                cartTableView.reloadData()
                
            } else {
                emptyView.isHidden = false
                cartView.isHidden = true
            }
        } else {
            
            for drinkData in Config.drinkCartArray {
                
                let name = Config.onCheckStringNull(object: drinkData.drinkObject, key: "name")
                let image = Config.onCheckFileNull(object: drinkData.drinkObject, key: "image")
                let desc = Config.onCheckStringNull(object: drinkData.drinkObject, key: "desc")
                let unitPrice = Config.onCheckStringNull(object: drinkData.drinkObject, key: "unitPrice")
                let unit = Config.onCheckStringNull(object: drinkData.drinkObject, key: "unit")
                let taxes = Config.onCheckStringNull(object: drinkData.drinkObject, key: "taxes")
                let hasGlass = drinkData.drinkObject["hasGlass"] as! Bool
                
                let orderData = OrderData.init(objectId: drinkData.drinkObject.objectId!, orderImage: image, orderName: name, orderDesc: desc, orderPrice: Float(unitPrice)!, orderUnit: unit, orderTax: Float(taxes)!, tipPrice: 0, tipPercent: 15)
                
                var glassData: GlassData
                
                if hasGlass {
                    
                    let glassName = Config.onCheckStringNull(object: drinkData.glassObject!, key: "name")
                    let glassImage = Config.onCheckFileNull(object: drinkData.glassObject!, key: "image")
                    let glassPrice = Config.onCheckStringNull(object: drinkData.glassObject!, key: "unitPrice")
                    let glassUnit = Config.onCheckStringNull(object: drinkData.glassObject!, key: "unit")
                    
                    glassData = GlassData.init(objectId: (drinkData.glassObject?.objectId)!, glassImage: glassImage, glassName: glassName, glassPrice: Float(glassPrice)!, glassUnit: glassUnit, glassNb: 0)
                } else {
                    glassData = GlassData.init(objectId: "", glassImage: "", glassName: "", glassPrice: 0.00, glassUnit: "", glassNb: 0)
                }
                
                let barName = Config.onCheckStringNull(object: drinkData.barObject, key: "name")
                let barTime = Config.onCheckNumberNull(object: drinkData.barObject, key: "orderMinutes")
                
                let cartData = CartData.init(objectId: drinkData.barObject.objectId!, place: barName, time: String(barTime), order: orderData, orderNb: drinkData.nbDrinks, hasGlass: hasGlass, glass: glassData)
                
                cartArray.append(cartData)
            }
            
            calculateTotalCartPrice()
            cartTableView.reloadData()
        }
        
    }
    
    func calculateTotalCartPrice() {
        
        var totalAmount = Float(0)
        
        for cartData in cartArray {
            let tipPrice = Float(cartData.orderNb) * Float(cartData.order.orderPrice) * Float(cartData.order.tipPercent) / 100
            let glassTotalAmount = Float(cartData.glass.glassNb) * Float(cartData.glass.glassPrice)
            
            totalAmount = totalAmount + tipPrice + Float(cartData.orderNb) * Float(cartData.order.orderPrice) + Float(glassTotalAmount)
        }
        
        cartTotalPriceLabel.text = String(format: "%.2f $", totalAmount)
    }
    
    // MARK: Actions
    
    @IBAction func navbarBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func emptyButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: Route.routeMyCart.unwind(.routeTabHome), sender: self)
    }
    
    @IBAction func editCreditButtonPressed(_ sender: Any) {
        Config.isEditCreditCard = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeMyCart.to(.routeCreditCard), sender: self)
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        
        for cartData in self.cartArray {
            if cartData.hasGlass && cartData.glass.glassNb == 0 {
                
                let alert = UIAlertController(title: localized("generic_alert"), message: localized("mycart_without_glass"), preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: localized("generic_cancel"), style: UIAlertActionStyle.cancel, handler: nil))
                alert.addAction(UIAlertAction(title: localized("generic_confirm"), style: UIAlertActionStyle.default, handler: { action in
                    self.processPayment()
                }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                return
            }
        }
        
        self.processPayment()
    }
    
    func processPayment() {

        Config.successArray.removeAll()
        
        var barIds = [String]()
        
        for cartData in self.cartArray {
            if !barIds.contains(cartData.objectId) {
                barIds.append(cartData.objectId)
                
                let startDate = NSDate()
                let date = startDate.addingTimeInterval(Double(cartData.time)! * 60.0)
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let waitingTime = formatter.string(from: date as Date)
                
                let orderCode = Config.randomNumber(length: 4)
                let successData = SuccessData.init(barName: cartData.place, barTime: cartData.time, orderCode: orderCode, waitingTime: waitingTime)
                
                Config.successArray.append(successData)
            }
        }
        
        self.moveToSuccess()
    }
    
    func moveToSuccess() {
        
        if Config.isMyCart {
            DBManager.deleteAllCart(email: Config.userEmail)
        } else {
            for cartData in self.cartArray {
                DBManager.deleteCart(email: Config.userEmail, barObjectId: cartData.objectId, drinkObjectId: cartData.order.objectId)
            }
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeMyCart.to(.routeSuccessOrder), sender: self)
    }
    
    // MARK: UITableView Delegate
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        
        cell.placeDesLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: cell.placeDesLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        cell.timeDesLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: cell.timeDesLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        
        let cartData = cartArray[indexPath.row]
        
        cell.placeLabel.text = cartData.place
        cell.timeLabel.text = cartData.time + " " + localized("home_minutes")
        
        let orderCell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell

        orderCell.orderImage.sd_setImage(with: URL(string: cartData.order.orderImage), placeholderImage: UIImage(named: "drinkPlaceholder"))
        orderCell.orderCountView.layer.cornerRadius = orderCell.orderCountView.frame.size.height / 2
        orderCell.orderCountLabel.text = String(cartData.orderNb)
        
        if cartData.orderNb == 0 {
            orderCell.orderCountView.isHidden = true
        } else {
            orderCell.orderCountView.isHidden = false
        }
        
        if cartData.order.orderDesc == "" {
            orderCell.orderNameLabel.isHidden = true
            orderCell.orderVolumeLabel.isHidden = true
            orderCell.orderTitleLabel.isHidden = false
            orderCell.orderTitleLabel.text = cartData.order.orderName
        } else {
            orderCell.orderNameLabel.isHidden = false
            orderCell.orderVolumeLabel.isHidden = false
            orderCell.orderTitleLabel.isHidden = true
            orderCell.orderNameLabel.text = cartData.order.orderName
            orderCell.orderVolumeLabel.text = cartData.order.orderDesc
        }
        
        orderCell.orderPriceLabel.text = String(format: "%.2f %@", cartData.order.orderPrice, cartData.order.orderUnit)
        orderCell.numberLabel.text = String(cartData.orderNb)
        orderCell.minusButton.addTarget(self, action: #selector(self.orderMinusButtonClicked), for: .touchUpInside)
        orderCell.plusButton.addTarget(self, action: #selector(self.orderPlusButtonClicked), for: .touchUpInside)
        
        cell.orderView.addSubview(orderCell)
        
        let percent = "%"
        cell.taxDesLabel.text = localized("mycart_tax_include") + " (" + String(format: "%.3f%@", cartData.order.orderTax, percent) + ")"
        
        let taxPrice = Float(cartData.orderNb) * Float(cartData.order.orderPrice) * Float(cartData.order.orderTax) / 100
        cell.taxPriceLabel.text = String(format: "%.2f $ CA", taxPrice)
        
        let taxBeforePrice = Float(cartData.orderNb) * Float(cartData.order.orderPrice) - taxPrice
        cell.taxBeforePriceLabel.text = String(format: "%.2f $ CA", taxBeforePrice)
        
        let subTotalPrice = Float(cartData.orderNb) * Float(cartData.order.orderPrice)
        cell.subTotalPriceLabel.text = String(format: "%.2f $ CA", subTotalPrice)
        
        if cartData.order.tipPercent == 0 {
            cell.tip0Button.backgroundColor = UIColor.white
            cell.tip0Button.setTitleColor(UIColor.black, for: .normal)
            cell.tip1Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip1Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip2Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip2Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip3Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip3Button.setTitleColor(UIColor.white, for: .normal)
        } else if cartData.order.tipPercent == 15 {
            cell.tip0Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip0Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip1Button.backgroundColor = UIColor.white
            cell.tip1Button.setTitleColor(UIColor.black, for: .normal)
            cell.tip2Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip2Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip3Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip3Button.setTitleColor(UIColor.white, for: .normal)
        } else if cartData.order.tipPercent == 20 {
            cell.tip0Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip0Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip1Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip1Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip2Button.backgroundColor = UIColor.white
            cell.tip2Button.setTitleColor(UIColor.black, for: .normal)
            cell.tip3Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip3Button.setTitleColor(UIColor.white, for: .normal)
        } else if cartData.order.tipPercent == 25 {
            cell.tip0Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip0Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip1Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip1Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip2Button.backgroundColor = colorHEX("0D0D0D")
            cell.tip2Button.setTitleColor(UIColor.white, for: .normal)
            cell.tip3Button.backgroundColor = UIColor.white
            cell.tip3Button.setTitleColor(UIColor.black, for: .normal)
        }
        
        cell.tip0Button.addTarget(self, action: #selector(self.tip0ButtonClicked), for: .touchUpInside)
        cell.tip1Button.addTarget(self, action: #selector(self.tip1ButtonClicked), for: .touchUpInside)
        cell.tip2Button.addTarget(self, action: #selector(self.tip2ButtonClicked), for: .touchUpInside)
        cell.tip3Button.addTarget(self, action: #selector(self.tip3ButtonClicked), for: .touchUpInside)
        
        let tipPrice = Float(cartData.orderNb) * Float(cartData.order.orderPrice) * Float(cartData.order.tipPercent) / 100
        cell.tipPriceLabel.text = String(format: "%.2f $ CA", tipPrice)
        
        var glassTotalAmount = Float(0)
        
        if cartData.hasGlass {
            
            cell.glassViewHeight.constant = 70
            
            let glassCell = tableView.dequeueReusableCell(withIdentifier: "GlassCell", for: indexPath) as! GlassCell
            
            glassCell.glassImage.sd_setImage(with: URL(string: cartData.glass.glassImage), placeholderImage: UIImage(named: "drinkCup"))
            glassCell.glassCountView.layer.cornerRadius = glassCell.glassCountView.frame.size.height / 2
            glassCell.glassCountLabel.text = String(cartData.glass.glassNb)
            
            if cartData.glass.glassNb == 0 {
                glassCell.glassCountView.isHidden = true
            } else {
                glassCell.glassCountView.isHidden = false
            }
            
            glassCell.glassNameLabel.text = cartData.glass.glassName
            glassCell.glassUnitPriceLabel.text = String(format: "%.2f %@", cartData.glass.glassPrice, cartData.glass.glassUnit)
            
            glassCell.numberLabel.text = String(cartData.glass.glassNb)
            
            let glassTotalPrice = Float(cartData.glass.glassNb) * Float(cartData.glass.glassPrice)
            glassCell.glassTotalPriceLabel.text = String(format: "%.2f %@", glassTotalPrice, cartData.order.orderUnit)
            
            glassCell.minusButton.addTarget(self, action: #selector(self.glassMinusButtonClicked), for: .touchUpInside)
            glassCell.plusButton.addTarget(self, action: #selector(self.glassPlusButtonClicked), for: .touchUpInside)
            
            glassTotalAmount = Float(cartData.glass.glassNb) * Float(cartData.glass.glassPrice)
            
            cell.glassView.addSubview(glassCell)
            
        } else {
            cell.glassViewHeight.constant = 0
        }
        
        let totalPrice = tipPrice + Float(cartData.orderNb) * Float(cartData.order.orderPrice) + Float(glassTotalAmount)
        cell.totalPriceLabel.text = String(format: "%.2f $ CA", totalPrice)
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    //-----------------------------
    
    @objc func orderMinusButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: cartTableView)
        let indexPath: IndexPath? = cartTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)

        var cartData = cartArray[(indexPath?.row)!]
        
        if cartData.orderNb == 1 {
            
            let alert = UIAlertController(title: localized("generic_alert"), message: localized("mycart_remove_order"), preferredStyle: UIAlertControllerStyle.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: localized("generic_cancel"), style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: localized("generic_confirm"), style: UIAlertActionStyle.default, handler: { action in
                
                DBManager.deleteCart(email: Config.userEmail, barObjectId: cartData.objectId, drinkObjectId: cartData.order.objectId)
                
                if self.cartArray.count == 1 {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    
                    self.cartArray.remove(at: (indexPath?.row)!)
                    self.calculateTotalCartPrice()
                    
                    self.cartTableView.reloadData()
                }
            }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        } else {
            cartData.orderNb = cartData.orderNb - 1
            cartArray.remove(at: (indexPath?.row)!)
            cartArray.insert(cartData, at: (indexPath?.row)!)
            
            calculateTotalCartPrice()
            
            UIView.performWithoutAnimation({
                let loc = cartTableView.contentOffset
                cartTableView.reloadRows(at: [indexPath!], with: .none)
                cartTableView.contentOffset = loc
            })
        }
    }
    
    @objc func orderPlusButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: cartTableView)
        let indexPath: IndexPath? = cartTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
        
        var cartData = cartArray[(indexPath?.row)!]
        
        cartData.orderNb = cartData.orderNb + 1
        cartArray.remove(at: (indexPath?.row)!)
        cartArray.insert(cartData, at: (indexPath?.row)!)
        
        calculateTotalCartPrice()
        
        UIView.performWithoutAnimation({
            let loc = cartTableView.contentOffset
            cartTableView.reloadRows(at: [indexPath!], with: .none)
            cartTableView.contentOffset = loc
        })
    }
    
    @objc func tip0ButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: cartTableView)
        let indexPath: IndexPath? = cartTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
        
        var cartData = cartArray[(indexPath?.row)!]
        
        cartData.order.tipPercent = 0
        cartArray.remove(at: (indexPath?.row)!)
        cartArray.insert(cartData, at: (indexPath?.row)!)
        
        calculateTotalCartPrice()
        
        UIView.performWithoutAnimation({
            let loc = cartTableView.contentOffset
            cartTableView.reloadRows(at: [indexPath!], with: .none)
            cartTableView.contentOffset = loc
        })
    }
    
    @objc func tip1ButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: cartTableView)
        let indexPath: IndexPath? = cartTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
        
        var cartData = cartArray[(indexPath?.row)!]
        
        cartData.order.tipPercent = 15
        cartArray.remove(at: (indexPath?.row)!)
        cartArray.insert(cartData, at: (indexPath?.row)!)
        
        calculateTotalCartPrice()
        
        UIView.performWithoutAnimation({
            let loc = cartTableView.contentOffset
            cartTableView.reloadRows(at: [indexPath!], with: .none)
            cartTableView.contentOffset = loc
        })
    }
    
    @objc func tip2ButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: cartTableView)
        let indexPath: IndexPath? = cartTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
     
        var cartData = cartArray[(indexPath?.row)!]
        
        cartData.order.tipPercent = 20
        cartArray.remove(at: (indexPath?.row)!)
        cartArray.insert(cartData, at: (indexPath?.row)!)
        
        calculateTotalCartPrice()
        
        UIView.performWithoutAnimation({
            let loc = cartTableView.contentOffset
            cartTableView.reloadRows(at: [indexPath!], with: .none)
            cartTableView.contentOffset = loc
        })
    }
    
    @objc func tip3ButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: cartTableView)
        let indexPath: IndexPath? = cartTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
        
        var cartData = cartArray[(indexPath?.row)!]
        
        cartData.order.tipPercent = 25
        cartArray.remove(at: (indexPath?.row)!)
        cartArray.insert(cartData, at: (indexPath?.row)!)
        
        calculateTotalCartPrice()
        
        UIView.performWithoutAnimation({
            let loc = cartTableView.contentOffset
            cartTableView.reloadRows(at: [indexPath!], with: .none)
            cartTableView.contentOffset = loc
        })
    }
    
    @objc func glassMinusButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: cartTableView)
        let indexPath: IndexPath? = cartTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
        
        var cartData = cartArray[(indexPath?.row)!]
        
        if cartData.glass.glassNb == 1 {
            
        } else {
            cartData.glass.glassNb = cartData.glass.glassNb - 1
            
            cartArray.remove(at: (indexPath?.row)!)
            cartArray.insert(cartData, at: (indexPath?.row)!)
            
            calculateTotalCartPrice()
            
            UIView.performWithoutAnimation({
                let loc = cartTableView.contentOffset
                cartTableView.reloadRows(at: [indexPath!], with: .none)
                cartTableView.contentOffset = loc
            })
        }
    }
    
    @objc func glassPlusButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: cartTableView)
        let indexPath: IndexPath? = cartTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
        
        var cartData = cartArray[(indexPath?.row)!]
        
        cartData.glass.glassNb = cartData.glass.glassNb + 1
        
        cartArray.remove(at: (indexPath?.row)!)
        cartArray.insert(cartData, at: (indexPath?.row)!)
        
        calculateTotalCartPrice()
        
        UIView.performWithoutAnimation({
            let loc = cartTableView.contentOffset
            cartTableView.reloadRows(at: [indexPath!], with: .none)
            cartTableView.contentOffset = loc
        })
    }
}
