//
//  ViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class LoginViewController: UIViewController {

    // MARK: Property
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    
    internal let homeCareService = HomeCaresService()
    
    // MARK: Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        emailTextField.addLeftImage("ic_email".image)
        passwordTextField.addLeftImage("ic_password".image)
    }
    
    internal func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailTextField.text!)
    }
    
    internal func isValidPassword() -> Bool {
        return passwordTextField.text!.trimmed.characters.count > 6
    }
    
    // MARK: Action

    @IBAction func loginAction(_ sender: Any) {
//        if !isValidEmail() {
//            showAlert(title: "Notice",
//                      message: "Please fill a valid email",
//                      negativeTitle: "OK")
//        }
//        if !isValidPassword() {
//            showAlert(title: "Notice",
//                      message: "Password is at least 7 characters",
//                      negativeTitle: "OK")
//        }
//        
//        homeCareService.login(userName: emailTextField.text!, password: passwordTextField.text!) { (user) in
//            
//        }
        guard let window = UIApplication.shared.keyWindow else { return }
//        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "mainController") as? UITabBarController {
            window.rootViewController = vc
        
        }
      //  window.rootViewController = UIStoryboard.i
        
        
    }
    
    @IBAction func loginFacebookAction(_ sender: Any) {
        
    }
    
}

