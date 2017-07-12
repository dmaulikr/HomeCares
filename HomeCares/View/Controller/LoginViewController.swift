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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    // MARK: Internal method
    
    internal func prepareUI() {
        emailTextField.font = UIFont(name:"Montserrat-Light", size:16)
        passwordTextField.font = UIFont(name:"Montserrat-Light", size:16)
        passwordTextField.dividerNormalColor = .clear
        emailTextField.dividerNormalColor = .clear

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
        if !isValidEmail() {
            showAlert(title: "Notice",
                      message: "Please fill a valid email",
                      negativeTitle: "OK")
        }
        if !isValidPassword() {
            showAlert(title: "Notice",
                      message: "Password is at least 7 characters",
                      negativeTitle: "OK")
        }
        
        homeCareService.login(userName: emailTextField.text!, password: passwordTextField.text!) { [weak self] (response) in
            
            guard let sSelf = self else {return}
            
            if let user = response.data {
                UserDefaults.userId = user.userPerson.personId
                UserDefaults.avatar = user.userPerson.avatar
                UserDefaults.nameUser = user.userPerson.firstName +  user.userPerson.middleName + user.userPerson.lastName
                guard let window = UIApplication.shared.keyWindow else { return }
                
                if let vc = sSelf.storyboard?.instantiateViewController(withIdentifier: "mainController") as? UITabBarController {
                    window.rootViewController = vc
                    
                }
            } else {
                sSelf.showAlert(
                    title: "Error",
                    message: "Username or passwork wrong.",
                    negativeTitle: "OK")
                
            }
        }
       
        
    }
    
    @IBAction func registerAction(_ sender: Any) {
        performSegue(withIdentifier: "ShowRegisterView", sender: nil)
    }
}

