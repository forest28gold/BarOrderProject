//
//  VerifyPhoneNumberController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class VerifyPhoneNumberController: Controller, UITextFieldDelegate, ShowsAlert {
    
    @IBOutlet var verifyLabel: UILabel!
    @IBOutlet var receiveLabel: UILabel!
    @IBOutlet var resendButton: UIButton!
    
    @IBOutlet var codeTextField: UITextField!
    
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
        
        codeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        verifyLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: verifyLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        receiveLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: receiveLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        
        let attrs = [NSAttributedStringKey.foregroundColor : UIColor.fromGradientWithDirection(.leftToRight, frame: resendButton.frame, colors: [colorHEX("2d176e"), colorHEX("cb75fa")]) as Any,
                     NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue] as [NSAttributedStringKey : Any]
        let attributeString = NSMutableAttributedString(string: localized("verify_resend_code"), attributes: attrs)
        resendButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    // MARK: UITapGesture
    
    @objc func handleTapFrom(recognizer : UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    // MARK: UITextField Delegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == codeTextField {
            dismissKeyboard()
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        codeTextField.attributedText = NSAttributedString(string: textField.text!, attributes:[ NSAttributedStringKey.kern: 5])
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: Actions
    
    @IBAction func navbarBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendCodeButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func verifyButtonPressed(_ sender: Any) {
        
//        if codeTextField.text == "" {
//            self.showAlert(message: localized("verify_code_error"))
//            return
//        }
//
//        dismissKeyboard()
        
        Config.isEditCreditCard = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeVerifyPhoneNumber.to(.routeCreditCard), sender: self)
    }
}
