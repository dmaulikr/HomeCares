//
//  RegisterViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/12/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material
import ActionSheetPicker_3_0
import SpringIndicator

class RegisterViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var firstNameLabel: TextField!
    @IBOutlet weak var middleNameLabel: TextField!
    @IBOutlet weak var lastNameLabel: TextField!
    @IBOutlet weak var emailLabel: TextField!
    @IBOutlet weak var phoneNumberLabel: TextField!
    @IBOutlet weak var birthdayLabel: TextField!
    @IBOutlet weak var genderLabel: TextField!
    @IBOutlet weak var passwordLabel: TextField!
    @IBOutlet weak var confirmPassword: TextField!
    @IBOutlet weak var registerButton: Button!
    
    
    internal var homecareService = HomeCaresService()
    internal var genderSelected = Gender.female
    internal var indicator: SpringIndicator!

    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        birthdayLabel.addRightImage("ic_arrow_down".image)
        genderLabel.addRightImage("ic_arrow_down".image)
        
        firstNameLabel.font = UIFont(name:"Montserrat-Light", size:16)
        middleNameLabel.font = UIFont(name:"Montserrat-Light", size:16)
        lastNameLabel.font = UIFont(name:"Montserrat-Light", size:16)
        emailLabel.font = UIFont(name:"Montserrat-Light", size:16)
        phoneNumberLabel.font = UIFont(name:"Montserrat-Light", size:16)
        birthdayLabel.font = UIFont(name:"Montserrat-Light", size:16)
        genderLabel.font = UIFont(name:"Montserrat-Light", size:16)
        passwordLabel.font = UIFont(name:"Montserrat-Light", size:16)
        confirmPassword.font = UIFont(name:"Montserrat-Light", size:16)
        
        firstNameLabel.placeholder = "First name"
        middleNameLabel.placeholder = "Middle name"
        lastNameLabel.placeholder = "Last name"
        emailLabel.placeholder = "Email"
        phoneNumberLabel.placeholder = "Phone number"
        birthdayLabel.placeholder = "Birthday"
        genderLabel.placeholder = "Gender"
        passwordLabel.placeholder = "Password"
        confirmPassword.placeholder = "Confirm password"

    }

    // MARK: Action
    
    @IBAction func resgisterAction(_ sender: Any) {
        if  !firstNameLabel.text!.isEmpty,
            !middleNameLabel.text!.isEmpty,
            !lastNameLabel.text!.isEmpty,
            !emailLabel.text!.isEmpty,
            !phoneNumberLabel.text!.isEmpty,
            !birthdayLabel.text!.isEmpty,
            !genderLabel.text!.isEmpty,
            !passwordLabel.text!.isEmpty,
            !confirmPassword.text!.isEmpty {
            if passwordLabel.text! == confirmPassword.text! {
                if !emailLabel.text!.isValidEmail() {
                    showAlert(
                        title: "Notice",
                        message: "Unvalidate email",
                        negativeTitle: "OK")
                    return
                }
                
                if !phoneNumberLabel.text!.isValidatePhone() {
                    showAlert(
                        title: "Notice",
                        message: "Unvalidate phone number",
                        negativeTitle: "OK")
                    return
                }
                let user = User()
                user.email = emailLabel.text!
                user.phoneNumber = phoneNumberLabel.text!
                user.userName = emailLabel.text!
                user.passwordHash = passwordLabel.text!
                user.phoneNumberConfirmed = false
                user.accessFailedCount = 0
                user.twoFactorEnabled = false
                let userPerson = UserPerson()
                userPerson.firstName = firstNameLabel.text!
                userPerson.middleName = middleNameLabel.text!
                userPerson.lastName = lastNameLabel.text!
                userPerson.gender = genderSelected
                let birthDay = birthdayLabel.text!
                let date = DateHelper.shared.date(from: birthDay, format: .dd_MM_yyyy)!
                userPerson.birthDay = DateHelper.shared.string(from: date, format: .yyyy_MM_dd_T_HH_mm_ss_Z)
                userPerson.created = "\(Date())"
                userPerson.updated = "\(Date())"
                user.userPerson = userPerson
                startWaitingRegister()
                homecareService.register(user: user, handler: { [weak self] response in
                    guard let sSelf = self else { return }
                    
                    sSelf.stopWaitingRegister()
                    if let _ = response.data {
                       sSelf.navigationController?.popViewController(animated: true)
                    } else {
                        
                    }
                })
            
            } else {
                showAlert(
                    title: "Notice",
                    message: "Password and Confirm Password is not match",
                    negativeTitle: "OK")
            }
        } else {
            showAlert(
                title: "Notice",
                message: "Please fill in information",
                negativeTitle: "OK")
        }
        
        
        
    }
    
    // Internal method
    
    internal func startWaitingRegister() {
        indicator = SpringIndicator()
        indicator.lineWidth = 2
        indicator.lineColor = .white
        
        registerButton.layout(indicator)
            .size(CGSize(width: 24, height: 24))
            .centerVertically()
            .right(8)
        indicator.startAnimation()
    }
    
    internal func stopWaitingRegister() {
        if indicator != nil, indicator.isSpinning() {
            indicator.stopAnimation(false)
        }
    }
    
    // MARK: Action
    
    @IBAction func chooseBirthdayAction(_ sender: Any) {
        let date = DateHelper.shared.date(from: birthdayLabel.text!, format: .dd_MM_yyyy) ?? Date()
        let datePicker = ActionSheetDatePicker(title: "Ngày sinh", datePickerMode: .date, selectedDate: date, doneBlock: {
            _, value, index in
            if let date = value as? Date {
                self.birthdayLabel.text = "\(DateHelper.shared.string(from: date, format: .dd_MM_yyyy))"
            }
            
        }, cancel: { ActionStringCancelBlock in return }, origin: view)
        datePicker?.show()

    }
    
    @IBAction func chooseGenderAction(_ sender: Any) {
        let gender = ["Female","Male","Other"]
        let initialSelection = gender.index(of: genderLabel.text!) ?? 0
        let picker = ActionSheetStringPicker(title: "Giới tính", rows: gender, initialSelection: initialSelection, doneBlock: { (_, index, value) in
            if let gen = value as? String {
                self.genderLabel.text = "\(gen)"
                self.genderSelected = Gender(rawValue: index)!
            }
        }, cancel: { (_) in
            return
        }, origin: view)
        picker?.show()
    }
    
 }
