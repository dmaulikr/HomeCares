//
//  AccountViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/16/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material
import ActionSheetPicker_3_0
import SpringIndicator
import MJSnackBar

class AccountViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var middleNameTextField: TextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var birthdayTextField: TextField!
    @IBOutlet weak var genderTextField: TextField!
    @IBOutlet weak var addressTextField: TextField!
    @IBOutlet weak var identifyTextField: TextField!
    @IBOutlet weak var updateAccountButton: RaisedButton!
    
    internal var isEdit = false
    internal var genderSelected = Gender.female
    internal var imageSelected: UIImage?
    internal var userPerson: UserPerson!
    internal var indicator: SpringIndicator!
    internal var homecareService = HomeCaresService()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        bindData()
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        birthdayTextField.addRightImage("ic_arrow_down".image)
        genderTextField.addRightImage("ic_arrow_down".image)
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAddImage)))

        firstNameTextField.font = UIFont(name:"Montserrat-Light", size:16)
        middleNameTextField.font = UIFont(name:"Montserrat-Light", size:16)
        lastNameTextField.font = UIFont(name:"Montserrat-Light", size:16)
        birthdayTextField.font = UIFont(name:"Montserrat-Light", size:16)
        addressTextField.font = UIFont(name:"Montserrat-Light", size:16)
        genderTextField.font = UIFont(name:"Montserrat-Light", size:16)
        identifyTextField.font = UIFont(name:"Montserrat-Light", size:16)
        firstNameTextField.dividerNormalColor = .darkGray
        middleNameTextField.dividerNormalColor = .darkGray
        lastNameTextField.dividerNormalColor = .darkGray
        addressTextField.dividerNormalColor = .darkGray
        genderTextField.dividerNormalColor = .darkGray
        identifyTextField.dividerNormalColor = .darkGray
        birthdayTextField.dividerNormalColor = .darkGray
        switchEditAccount()
    }
    
    internal func bindData() {
        if let url = URL(string: userPerson.avatar) {
            avatarImageView.af_setImage(
                withURL         : url,
                placeholderImage: "ic_user_default".image,
                imageTransition : .crossDissolve(0.2),
                completion: { (response) in
                    if let _  = response.result.error {
                        self.avatarImageView.image = "ic_user_default".image
                    }
            })
        } else {
            self.avatarImageView.image = "ic_user_default".image
        }
        nameLabel.text = "\(userPerson.firstName!) \(userPerson.middleName!) \(userPerson.lastName!)"
        detailLabel.text = userPerson.subInfor
        firstNameTextField.text = userPerson.firstName
        middleNameTextField.text = userPerson.middleName
        lastNameTextField.text = userPerson.lastName
        birthdayTextField.text = userPerson.birthDay.date(format: .dd_MM_yyyy)
        genderTextField.text = userPerson.gender! == .male ? "Male" : userPerson.gender! == .male ? "Female" : "Other"
        addressTextField.text = userPerson.address
        identifyTextField.text = userPerson.idCardNumber
    }
    
    internal func switchEditAccount() {
        
        firstNameTextField.isEnabled = isEdit
        middleNameTextField.isEnabled = isEdit
        lastNameTextField.isEnabled = isEdit
        birthdayTextField.isEnabled = isEdit
        addressTextField.isEnabled = isEdit
        genderTextField.isEnabled = isEdit
        identifyTextField.isEnabled = isEdit
        UIView.animate(withDuration: 0.5) {
            self.updateAccountButton.isHidden = !self.isEdit
            self.updateAccountButton.alpha = self.isEdit ? 1 : 0
        }
        
        if !isEdit {
            birthdayTextField.addRightImage(nil)
            genderTextField.addRightImage(nil)
            
        } else {
            birthdayTextField.addRightImage("ic_arrow_down".image)
            genderTextField.addRightImage("ic_arrow_down".image)
        }

    }
    
    internal func updateAccount() {
        if !firstNameTextField.text!.isEmpty,
        !middleNameTextField.text!.isEmpty,
        !lastNameTextField.text!.isEmpty,
        !birthdayTextField.text!.isEmpty,
        !addressTextField.text!.isEmpty,
        !genderTextField.text!.isEmpty {
            userPerson.firstName = firstNameTextField.text!
            userPerson.middleName = middleNameTextField.text!
            userPerson.lastName = lastNameTextField.text!
            userPerson.address = addressTextField.text!
            userPerson.gender = genderSelected
            userPerson.updated = "\(Date())"
            userPerson.idCardNumber = identifyTextField.text!
            if let date = DateHelper.shared.date(from: birthdayTextField.text!, format: .dd_MM_yyyy) {
                userPerson.birthDay = DateHelper.shared.string(from: date, format: .yyyy_MM_dd_T_HH_mm_ss_Z)
            }
            startWaiting()
            homecareService.updateUserPerson(userPerson: userPerson, handler: {[weak self] (response) in
                guard let sSelf = self else {return}
                
                sSelf.stopWaiting()
                if let _ = response.data {
                    sSelf.showSnackBar(message: "You updated successfully")
                    if #available(iOS 10.0, *) {
                        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                            sSelf.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        let _ = Timer.scheduledTimer(timeInterval: 1, target: sSelf, selector: #selector(sSelf.backToMore), userInfo: nil, repeats: false)
                    }

                } else if let error = response.error {
                    sSelf.showAlert(title: "Error",
                                    message: error.localizedDescription,
                                    negativeTitle: "OK")
                }
            })

        } else {
            showAlert(title: "Notice",
                      message: "Please fill in information",
                      negativeTitle: "OK")
        }
    }
    
    internal func backToMore() {
        navigationController?.popViewController(animated: true)
    }
    
    
    internal func startWaiting() {
        indicator = SpringIndicator()
        indicator.lineWidth = 2
        indicator.lineColor = .white
        
        updateAccountButton.layout(indicator)
            .size(CGSize(width: 24, height: 24))
            .centerVertically()
            .right(8)
        indicator.startAnimation()
    }
    
    internal func stopWaiting() {
        if indicator != nil, indicator.isSpinning() {
            indicator.stopAnimation(false)
        }
    }
    public func showSnackBar(message: String) {
        let snackBar = MJSnackBar(onView: self.view)
        snackBar.show(data: MJSnackBarData(message: message), onView: self.view)
    }
    
    internal func showAddImage() {
        
        let alertController = UIAlertController(title: "Select image", message: nil, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.handleSelectProfile()
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(galleryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        if let popupOver = alertController.popoverPresentationController {
            popupOver.sourceView = avatarImageView
        }
        showDetailViewController(alertController, sender: nil)
    }
    
    // MARK: Action
    
    
    
    @IBAction func choseBirthdayAction(_ sender: Any) {
        if isEdit {
            let date = DateHelper.shared.date(from: birthdayTextField.text!, format: .dd_MM_yyyy) ?? Date()
            let datePicker = ActionSheetDatePicker(title: "Ngày sinh", datePickerMode: .date, selectedDate: date, doneBlock: {
                _, value, index in
                if let date = value as? Date {
                    self.birthdayTextField.text = "\(DateHelper.shared.string(from: date, format: .dd_MM_yyyy))"
                }
                
            }, cancel: { ActionStringCancelBlock in return }, origin: view)
            datePicker?.show()
        }
        
    }
    @IBAction func choseGenderAction(_ sender: Any) {
        if isEdit {
            let gender = ["Female","Male","Other"]
            let initialSelection = gender.index(of: genderTextField.text!) ?? 0
            let picker = ActionSheetStringPicker(title: "Giới tính", rows: gender, initialSelection: initialSelection, doneBlock: { (_, index, value) in
                if let gen = value as? String {
                    self.genderTextField.text = "\(gen)"
                    self.genderSelected = Gender(rawValue: index)!
                }
            }, cancel: { (_) in
                return
            }, origin: view)
            picker?.show()
        }
    }

    @IBAction func editProfileAction(_ sender: Any) {
        isEdit = !isEdit
        switchEditAccount()
    }
    
    @IBAction func updateAccountAction(_ sender: Any) {
        updateAccount()
    }
    
    @IBAction func choseAddImageAction(_ sender: Any) {
        if isEdit {
            showAddImage()
        }
    }
    
}


extension AccountViewController: UIImagePickerControllerDelegate {
    func handleSelectProfile() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            avatarImageView.image = image
            imageSelected = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

