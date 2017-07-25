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
        
        firstNameLabel.font = UIFont(name:"Montserrat-Light", size:15)
        middleNameLabel.font = UIFont(name:"Montserrat-Light", size:15)
        lastNameLabel.font = UIFont(name:"Montserrat-Light", size:15)
        emailLabel.font = UIFont(name:"Montserrat-Light", size:15)
        phoneNumberLabel.font = UIFont(name:"Montserrat-Light", size:15)
        birthdayLabel.font = UIFont(name:"Montserrat-Light", size:15)
        genderLabel.font = UIFont(name:"Montserrat-Light", size:15)
        passwordLabel.font = UIFont(name:"Montserrat-Light", size:15)
        confirmPassword.font = UIFont(name:"Montserrat-Light", size:15)
        
        firstNameLabel.dividerNormalColor = .darkGray
        middleNameLabel.dividerNormalColor = .darkGray
        lastNameLabel.dividerNormalColor = .darkGray
        emailLabel.dividerNormalColor = .darkGray
        phoneNumberLabel.dividerNormalColor = .darkGray
        birthdayLabel.dividerNormalColor = .darkGray
        genderLabel.dividerNormalColor = .darkGray
        passwordLabel.dividerNormalColor = .darkGray
        confirmPassword.dividerNormalColor = .darkGray

        genderLabel.text = "Nữ"
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
                        title: "Chú ý",
                        message: "Email không hợp lệ.",
                        negativeTitle: "OK")
                    return
                }
                
                if !phoneNumberLabel.text!.isValidatePhone() {
                    showAlert(
                        title: "Chú ý",
                        message: "Số điện thoại không hợp lệ.",
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
                user.emailConfirmed = false
                let userPerson = UserPerson()
                userPerson.firstName = firstNameLabel.text!
                userPerson.middleName = middleNameLabel.text!
                userPerson.lastName = lastNameLabel.text!
                userPerson.gender = genderSelected
                userPerson.balances = 0
                userPerson.avatar = ""
                userPerson.longitude = 0
                userPerson.latitude = 0
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
                        sSelf.showAlert(title: "Thông báo", message: "Tài khoản được tạo thành công.", negativeTitle: "OK", negativeHandler: { _ in
                            sSelf.navigationController?.popViewController(animated: true)
                        })
                       
                    } else if let _ = response.error {
                        sSelf.showAlert(title: "Lỗi", message: "Email đã tồn tại.", negativeTitle: "OK")
                    }
                })
            
            } else {
                showAlert(
                    title: "Chú ý",
                    message: "Mật khẩu không khớp.",
                    negativeTitle: "OK")
            }
        } else {
            showAlert(
                title: "Chú ý",
                message: "Vui lòng điền đầy đủ thông tin.",
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
                self.birthdayLabel.text = DateHelper.shared.string(from: date, format: .dd_MM_yyyy)
            }
            
        }, cancel: { ActionStringCancelBlock in return }, origin: birthdayLabel)
        datePicker?.show()

    }
    
    @IBAction func chooseGenderAction(_ sender: Any) {
        let gender = ["Nữ","Nam","Khác"]
        let initialSelection = gender.index(of: genderLabel.text!) ?? 0
        let picker = ActionSheetStringPicker(title: "Giới tính", rows: gender, initialSelection: initialSelection, doneBlock: { (_, index, value) in
            if let gen = value as? String {
                self.genderLabel.text = "\(gen)"
                self.genderSelected = Gender(rawValue: index)!
            }
        }, cancel: { (_) in
            return
        }, origin: genderLabel)
        picker?.show()
    }
    
 }
