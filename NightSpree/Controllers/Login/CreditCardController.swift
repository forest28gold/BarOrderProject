//
//  CreditCardController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class CreditCardController: Controller, UITextFieldDelegate, ShowsAlert {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    @IBOutlet var cardNumberLabel: UILabel!
    @IBOutlet var expireDateLabel: UILabel!
    @IBOutlet var cryptoLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var cardNameLabel: UILabel!
    
    @IBOutlet var cardImageView: UIImageView!
    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var expireDateTextField: UITextField!
    @IBOutlet var cryptoTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var cardNameTextField: UITextField!
    
    @IBOutlet var secureButton: UIButton!
    @IBOutlet var scanCardButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom(recognizer:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        
        if Config.isEditCreditCard {
            deleteButton.isHidden = false
            scanCardButton.isHidden = true
            registerButton.isHidden = true
            titleLabel.text = localized("credit_edit")
        } else {
            deleteButton.isHidden = true
            titleLabel.text = localized("credit_add_payment")
        }
        
        cardNumberLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: cardNumberLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        expireDateLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: expireDateLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        cryptoLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: cryptoLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        codeLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: codeLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        cardNameLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: cardNameLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        
        scanCardButton.layer.borderWidth = 1.0
        scanCardButton.layer.borderColor = colorHEX("634279").cgColor
    }
    
    // MARK: UITapGesture
    
    @objc func handleTapFrom(recognizer : UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    // MARK: UITextField Delegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == cardNumberTextField {
            expireDateTextField.becomeFirstResponder()
        } else if textField == cryptoTextField {
            codeTextField.becomeFirstResponder()
        } else if textField == codeTextField {
            cardNameTextField.becomeFirstResponder()
        } else if textField == cardNameTextField {
            dismissKeyboard()
        }
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }

        if textField == cardNumberTextField { // Card Number Text Field
            textField.text = currentText.grouping(every: 4, with: " ")
            checkMaxLength(textField: textField, maxLength: 19)
            return false
        } else if textField == expireDateTextField { // Expiry Date Text Field
            textField.text = currentText.grouping(every: 2, with: "/")
            checkMaxLength(textField: textField, maxLength: 5)
            return false
        } else if textField == cryptoTextField {
            if (textField.text!.count > 3) {
                textField.deleteBackward()
            }
            return true
        } else {
            return true
        }
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
            textField.deleteBackward()
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: Actions
    
    @IBAction func navbarBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func navbarDeleteButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
//        if cardNumberTextField.text == "" {
//            self.showAlert(message: localized("credit_number_error"))
//            return
//        } else if expireDateTextField.text == "" {
//            self.showAlert(message: localized("credit_expire_date_error"))
//            return
//        } else if cryptoTextField.text == "" {
//            self.showAlert(message: localized("credit_crypto_error"))
//            return
//        } else if codeTextField.text == "" {
//            self.showAlert(message: localized("credit_code_error"))
//            return
//        } else if cardNameTextField.text == "" {
//            self.showAlert(message: localized("credit_name_error"))
//            return
//        }
//
//        dismissKeyboard()
        
        if Config.isEditCreditCard {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.performSegue(withIdentifier: Route.routeCreditCard.to(.routeCongratulations), sender: self)
        }
    }
    
    @IBAction func scanCardButtonPressed(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeCreditCard.to(.routeScanCard), sender: self)
    }
}
