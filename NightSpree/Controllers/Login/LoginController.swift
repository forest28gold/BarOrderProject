//
//  LoginController.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/7/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import UIKit

class LoginController: Controller, UITextFieldDelegate, ShowsAlert {
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var isKeyboard = true
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
        
        emailLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: emailLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
        passwordLabel.textColor = UIColor.fromGradientWithDirection(.leftToRight, frame: passwordLabel.frame, colors: [colorHEX("22096d"), colorHEX("b178d0")])
    }
    
    // MARK: UITapGesture
    
    @objc func handleTapFrom(recognizer : UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    // MARK: UIKeyboard Notificaiton
    
    @objc func keyBoardDidShow(notification: NSNotification) {
        //handle appearing of keyboard here
        if isKeyboard {
            self.view.frame.origin.y = -100
        }
    }
    
    @objc func keyBoardDidHide(notification: NSNotification) {
        //handle dismiss of keyboard here
        self.view.frame.origin.y = 0
    }
    
    // MARK: UITextField Delegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            dismissKeyboard()
        }
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        isKeyboard = true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isKeyboard = true
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: Actions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
//        if emailTextField.text == "" {
//            self.showAlert(message: localized("login_email_error"))
//            return
//        } else if !Config.validateEmail(enteredEmail: emailTextField.text!) {
//            self.showAlert(message: localized("login_email_format_error"))
//            return
//        } else if passwordTextField.text == "" {
//            self.showAlert(message: localized("login_password_error"))
//            return
//        }
//
//        dismissKeyboard()
        
        goMain()
    }
    
    @IBAction func loginWithFacebookButtonPressed(_ sender: Any) {
        goMain()
    }
    
    func goMain() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "login")
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeLogin.to(.routeMain), sender: self)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: Route.routeLogin.to(.routeSignup), sender: self)
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        isKeyboard = false
        showForgotPasswordAlert()
    }
    
    func showForgotPasswordAlert() {
        
        let alertController = UIAlertController(title: localized("login_forgot_password"), message: localized("login_email_error"), preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: localized("generic_submit"), style: .default, handler: {
            alert -> Void in
            
            let emailTextField = alertController.textFields![0] as UITextField
            if emailTextField.text != "" {
                
            } else if !Config.validateEmail(enteredEmail: emailTextField.text!) {
                let errorAlert = UIAlertController(title: localized("generic_alert"), message: localized("login_email_format_error"), preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: localized("generic_ok"), style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
            } else {
                let errorAlert = UIAlertController(title: localized("generic_alert"), message: localized("login_email_error"), preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: localized("generic_ok"), style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
            }
        })
        let cancelAction = UIAlertAction(title: localized("generic_cancel"), style: .cancel, handler: nil)
        // add the textField
        alertController.addTextField { (textField : UITextField!) -> Void in
            //textField.placeholder = "Tracking Number"
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 18)
            textField.returnKeyType = UIReturnKeyType.done
            textField.keyboardType = UIKeyboardType.emailAddress
        }
        // add the actions (buttons)
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        // show the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
}
