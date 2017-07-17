//
//  ViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material
import SpringIndicator

class LoginViewController: UIViewController {

    // MARK: Property
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var loginButton: RaisedButton!
    
    internal var indicator: SpringIndicator!
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

    
    internal func isValidPassword() -> Bool {
        return passwordTextField.text!.trimmed.characters.count > 6
    }
    
    internal func startWaitingLogin() {
        indicator = SpringIndicator()
        indicator.lineWidth = 2
        indicator.lineColor = .white
        
        loginButton.layout(indicator)
            .size(CGSize(width: 24, height: 24))
            .centerVertically()
            .right(8)
        indicator.startAnimation()
    }
    
    internal func stopWaitingLogin() {
        if indicator != nil, indicator.isSpinning() {
            indicator.stopAnimation(false)
        }
    }
    
    
    // MARK: Action

    @IBAction func loginAction(_ sender: Any) {
        if !emailTextField.text!.isValidEmail() {
            showAlert(title: "Notice",
                      message: "Please fill a valid email",
                      negativeTitle: "OK")
            return
        }
        if !isValidPassword() {
            showAlert(title: "Notice",
                      message: "Password is at least 7 characters",
                      negativeTitle: "OK")
            return
        }
        startWaitingLogin()
        beginIgnoringEvent()
        homeCareService.login(userName: emailTextField.text!, password: passwordTextField.text!) { [weak self] (response) in
            guard let sSelf = self else {return}
            sSelf.endIgnoringEvent()
            sSelf.stopWaitingLogin()
            
            if let user = response.data {
                UserDefaults.personId = user.userPerson.personId
                UserDefaults.userId = user.id
                UserDefaults.avatar = user.userPerson.avatar
                UserDefaults.email = user.email
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

