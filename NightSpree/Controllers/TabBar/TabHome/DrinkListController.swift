//
//  DrinkListController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit
import Parse
import AudioToolbox

class DrinkListController: Controller, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var navbarCartButton: UIButton!
    @IBOutlet var navbarCartBadgeView: UIView!
    @IBOutlet var navbarCartBadgeLabel: UILabel!
    
    @IBOutlet var drinkTableView: UITableView!
    
    @IBOutlet var cartCountView: UIView!
    @IBOutlet var cartCountLabel: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!

    @IBOutlet weak var cartButtonHeight: NSLayoutConstraint!
    
    var categoryArray = [PFObject]()
    var drinkArray = [[DrinkData]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadLayout()
        self.initLoadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavCart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Layout
    
    func loadLayout() {
        Config.drinkListCtrl = self
        
        navbarCartBadgeView.layer.cornerRadius = navbarCartBadgeView.frame.size.height / 2
        cartCountView.layer.cornerRadius = cartCountView.frame.size.height / 2
        
        cartCountView.isHidden = true
        cartButtonHeight.constant = CGFloat(0)
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
        
        self.showLoading(status: localized("generic_wait"))
        
        let query = PFQuery(className: Const.ParseClass.DrinkClass)
        query.includeKey("glass")
        query.includeKey("bar")
        query.includeKey("category")
        query.includeKey("subcategory")
        query.whereKey("bar", equalTo:Config.barObject)
        query.order(byAscending: "category")
        query.addAscendingOrder("subcategory")
        query.findObjectsInBackground (block: { (objects, error) in
            
            self.stopLoading()
            
            if error == nil {
                if let objects = objects {
                    
                    var categoryIds = [String]()
                    var subcategoryIds = [String]()
                    var subDrinkArray = [DrinkData]()
                    
                    for object in objects {
                        let price = Config.onCheckStringNull(object: object, key: "unitPrice")
                        let barObject = object["bar"] as! PFObject
                        let categoryObject = object["category"] as! PFObject
                        let subcategoryObject = object["subcategory"] as! PFObject
                        let glassObject = object["glass"] as? PFObject
                        let drinkData = DrinkData.init(drinkObject: object, nbDrinks: 0, price: Float(price)!, glassObject: glassObject, barObject: barObject, categoryObject: categoryObject, subcategoryObject: subcategoryObject, isSubcategory: false)
                        
                        if !categoryIds.contains(categoryObject.objectId!) {
                            categoryIds.append(categoryObject.objectId!)
                            self.categoryArray.append(categoryObject)
                            
                            subcategoryIds.removeAll()
                            subcategoryIds.append(subcategoryObject.objectId!)
                            subDrinkArray.removeAll()
                            let subCategoryData = DrinkData.init(drinkObject: object, nbDrinks: 0, price: Float(price)!, glassObject: glassObject, barObject: barObject, categoryObject: categoryObject, subcategoryObject: subcategoryObject, isSubcategory: true)
                            subDrinkArray.append(subCategoryData)
                            subDrinkArray.append(drinkData)
                            
                            self.drinkArray.append(subDrinkArray)
                            
                        } else {
                            
                            if !subcategoryIds.contains(subcategoryObject.objectId!) {
                                subcategoryIds.append(subcategoryObject.objectId!)
                                let subCategoryData = DrinkData.init(drinkObject: object, nbDrinks: 0, price: Float(price)!, glassObject: glassObject, barObject: barObject, categoryObject: categoryObject, subcategoryObject: subcategoryObject, isSubcategory: true)
                                subDrinkArray.append(subCategoryData)
                                subDrinkArray.append(drinkData)
                            } else {
                                subDrinkArray.append(drinkData)
                            }
                            
                            self.drinkArray.remove(at: categoryIds.count - 1)
                            self.drinkArray.insert(subDrinkArray, at: categoryIds.count - 1)
                        }
                    }
                    self.drinkTableView.reloadData()
                }
            } else {
                
            }
        })
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
    
    @IBAction func viewCartButtonPressed(_ sender: Any) {
        
        Config.drinkCartArray.removeAll()
        
        for subDrinkArray in self.drinkArray {
            for drinkData in subDrinkArray {
                if drinkData.nbDrinks > 0 {
                    Config.drinkCartArray.append(drinkData)
                }
            }
        }
        
        Config.isMyCart = false
        Config.mainCtrl?.goMyCart()
    }
    
    // MARK: UITableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
        
        let categoryLable = cell?.viewWithTag(1) as? UILabel
        let categoryImage = cell?.viewWithTag(2) as? UIImageView
        
        let name = Config.onCheckStringNull(object: self.categoryArray[section], key: "name")
        let image = Config.onCheckFileNull(object: self.categoryArray[section], key: "image")
        
        categoryLable?.text = name
        categoryImage?.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "categoryPlaceholder"))
        
        return cell
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.drinkArray[indexPath.section][indexPath.row].isSubcategory {
            return 27
        } else {
            return 80
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.drinkArray[indexPath.section][indexPath.row].isSubcategory {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "KindCell", for: indexPath as IndexPath)
            
            let kindLable = cell.viewWithTag(1) as? UILabel
            
            let subcategory = self.drinkArray[indexPath.section][indexPath.row].subcategoryObject
            
            kindLable?.text = Config.onCheckStringNull(object: subcategory, key: "name")
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath as IndexPath)
            
            let drinkImage = cell.viewWithTag(1) as? UIImageView
            let countView = cell.viewWithTag(2)
            let countLable = cell.viewWithTag(3) as? UILabel
            let drinkNameLable = cell.viewWithTag(4) as? UILabel
            let nameLable = cell.viewWithTag(5) as? UILabel
            let drinkQuantityLable = cell.viewWithTag(6) as? UILabel
            let priceLable = cell.viewWithTag(7) as? UILabel
            let addButton = cell.viewWithTag(8) as? UIButton
            
            countView?.layer.cornerRadius = (countView?.frame.size.height)! / 2
            
            let drinkData = self.drinkArray[indexPath.section][indexPath.row]
            let name = Config.onCheckStringNull(object: drinkData.drinkObject, key: "name")
            let image = Config.onCheckFileNull(object: drinkData.drinkObject, key: "image")
            let desc = Config.onCheckStringNull(object: drinkData.drinkObject, key: "desc")
            let unitPrice = Config.onCheckStringNull(object: drinkData.drinkObject, key: "unitPrice")
            let unit = Config.onCheckStringNull(object: drinkData.drinkObject, key: "unit")
            
            if drinkData.nbDrinks == 0 {
                countView?.isHidden = true
            } else {
                countView?.isHidden = false
                countLable?.text = String(drinkData.nbDrinks)
            }
            
            drinkImage?.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "drinkPlaceholder"))
            
            if desc == "" {
                drinkNameLable?.isHidden = true
                drinkQuantityLable?.isHidden = true
                nameLable?.isHidden = false
                nameLable?.text = name
            } else {
                drinkNameLable?.isHidden = false
                drinkQuantityLable?.isHidden = false
                nameLable?.isHidden = true
                drinkNameLable?.text = name
                drinkQuantityLable?.text = desc
            }
            
            priceLable?.text = unitPrice + " " + unit
            
            addButton?.addTarget(self, action: #selector(self.addButtonClicked), for: .touchUpInside)
            
            return cell
        }
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    //-----------------------------
    
    @objc func addButtonClicked(_ sender: Any) {
        let btn = sender as? UIButton
        let buttonFrameInTableView: CGRect? = btn?.convert(btn?.bounds ?? CGRect.zero, to: drinkTableView)
        let indexPath: IndexPath? = drinkTableView.indexPathForRow(at: buttonFrameInTableView?.origin ?? CGPoint.zero)
        
        var drinkData = self.drinkArray[(indexPath?.section)!][(indexPath?.row)!]
        
        let barObjectId = drinkData.barObject.objectId
        let barName = Config.onCheckStringNull(object: drinkData.barObject, key: "name")
        let barTime = Config.onCheckNumberNull(object: drinkData.barObject, key: "orderMinutes")
        let drinkObjectId = drinkData.drinkObject.objectId
        let drinkName = Config.onCheckStringNull(object: drinkData.drinkObject, key: "name")
        let drinkImage = Config.onCheckFileNull(object: drinkData.drinkObject, key: "image")
        let drinkDesc = Config.onCheckStringNull(object: drinkData.drinkObject, key: "desc")
        let drinkUnitPrice = Config.onCheckStringNull(object: drinkData.drinkObject, key: "unitPrice")
        let drinkUnit = Config.onCheckStringNull(object: drinkData.drinkObject, key: "unit")
        let drinkTaxes = Config.onCheckStringNull(object: drinkData.drinkObject, key: "taxes")
        let hasGlass = drinkData.drinkObject["hasGlass"] as! Bool
        
        var glassObjectId = "", glassName = "", glassImage = "", glassUnitPrice = "", glassUnit = ""
        
        if hasGlass {
            glassObjectId = (drinkData.glassObject?.objectId)!
            glassName = Config.onCheckStringNull(object: drinkData.glassObject!, key: "name")
            glassImage = Config.onCheckFileNull(object: drinkData.glassObject!, key: "image")
            glassUnitPrice = Config.onCheckStringNull(object: drinkData.glassObject!, key: "unitPrice")
            glassUnit = Config.onCheckStringNull(object: drinkData.glassObject!, key: "unit")
        }
        
        let cart = Cart.init(id: nil, userEmail: Config.userEmail, barObjectId: barObjectId!, barName: barName, barTime: barTime, drinkObjectId: drinkObjectId!, drinkName: drinkName, drinkImage: drinkImage, drinkDesc: drinkDesc, drinkUnitPrice: drinkUnitPrice, drinkUnit: drinkUnit, drinkTaxes: drinkTaxes, nbDrinks: 1, hasGlass: hasGlass, glassObjectId: glassObjectId, glassName: glassName, glassImage: glassImage, glassUnitPrice: glassUnitPrice, glassUnit: glassUnit, nbGlasses: 0)
        
        if DBManager.existCart(cart: cart) {
            
            let alert = UIAlertController(title: localized("generic_alert"), message: localized("drink_add_cart_alert"), preferredStyle: UIAlertControllerStyle.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: localized("generic_cancel"), style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: localized("generic_confirm"), style: UIAlertActionStyle.default, handler: { action in
                
                DBManager.insertCart(cart: cart)
                
                drinkData.nbDrinks = drinkData.nbDrinks + 1
                
                var subDrinkArray = self.drinkArray[(indexPath?.section)!]
                subDrinkArray.remove(at: (indexPath?.row)!)
                subDrinkArray.insert(drinkData, at: (indexPath?.row)!)
                
                self.drinkArray.remove(at: (indexPath?.section)!)
                self.drinkArray.insert(subDrinkArray, at: (indexPath?.section)!)
                
                self.drinkTableView.reloadData()
                
                self.calculateTotalAmount()
                
                self.showNavCart()
                
//                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
            }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            DBManager.insertCart(cart: cart)
            
            drinkData.nbDrinks = drinkData.nbDrinks + 1
            
            var subDrinkArray = self.drinkArray[(indexPath?.section)!]
            subDrinkArray.remove(at: (indexPath?.row)!)
            subDrinkArray.insert(drinkData, at: (indexPath?.row)!)
            
            self.drinkArray.remove(at: (indexPath?.section)!)
            self.drinkArray.insert(subDrinkArray, at: (indexPath?.section)!)
            
            drinkTableView.reloadData()
            
            calculateTotalAmount()
            
            self.showNavCart()
            
//            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
//        UIView.performWithoutAnimation({
//            let loc = drinkTableView.contentOffset
//            drinkTableView.reloadRows(at: [indexPath!], with: .none)
//            drinkTableView.contentOffset = loc
//        })
    }
    
    // MARK: Calculate Order Cart
    
    func calculateTotalAmount() {
        var totalAmount = Float(0)
        var totalCount = 0
        
        for subDrinkArray in self.drinkArray {
            for drinkData in subDrinkArray {
                totalAmount = totalAmount + Float(drinkData.nbDrinks) * drinkData.price
                totalCount = totalCount + drinkData.nbDrinks
            }
        }
        
        cartCountView.isHidden = false
        cartButtonHeight.constant = CGFloat(50)
        
        totalPriceLabel.text = String(format: "%.2f $", totalAmount)
        cartCountLabel.text = String(totalCount)
    }
}
