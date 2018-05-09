//
//  SignupController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class SignupController: Controller, UITextFieldDelegate, ShowsAlert, UIGestureRecognizerDelegate {
    
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var termsButton: UIButton!
    
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom(recognizer:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
        
        phoneLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: phoneLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        emailLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: emailLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        passwordLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: passwordLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        
        let attrs = [NSAttributedStringKey.foregroundColor : UIColor.white,
                     NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue] as [NSAttributedStringKey : Any]
        let attributeString = NSMutableAttributedString(string: localized("signup_terms_condition"), attributes: attrs)
        termsButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    // MARK: Navigation Back Swipe Gesture
    
    func swipeToPop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return true
        }
        return false
    }
    
    // MARK: UITapGesture
    
    @objc func handleTapFrom(recognizer : UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    // MARK: UIKeyboard Notificaiton
    
    @objc func keyBoardDidShow(notification: NSNotification) {
        //handle appearing of keyboard here
        self.view.frame.origin.y = -100
    }
    
    @objc func keyBoardDidHide(notification: NSNotification) {
        //handle dismiss of keyboard here
        self.view.frame.origin.y = 0
    }
    
    // MARK: UITextField Delegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            dismissKeyboard()
        }
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: Actions
    
    @IBAction func navbarBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        
//        if phoneTextField.text == "" {
//            self.showAlert(message: localized("signup_phone_error"))
//            return
//        } else if emailTextField.text == "" {
//            self.showAlert(message: localized("login_email_error"))
//            return
//        } else if !Config.validateEmail(enteredEmail: emailTextField.text!) {
//            self.showAlert(message: localized("login_email_format_error"))
//            return
//        } else if passwordTextField.text == "" {
//            self.showAlert(message: localized("login_password_error"))
//            return
//        } else if (passwordTextField.text?.count)! < 6 {
//            self.showAlert(message: localized("signup_password_length_error"))
//            return
//        }
//        
//        dismissKeyboard()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeSignup.to(.routeVerifyPhoneNumber), sender: self)
    }
    
    @IBAction func signupWithFacebookButtonPressed(_ sender: Any) {
        Config.isEditCreditCard = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeSignup.to(.routeCreditCard), sender: self)
    }
    
    @IBAction func termsButtonPressed(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeSignup.to(.routeTerms), sender: self)
    }
}
