//
//  ProfileViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/5/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Material
import ActionSheetPicker_3_0
import SpringIndicator
import MJSnackBar

class ProfileViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var middleNameTextField: TextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var birthdayTextField: TextField!
    @IBOutlet weak var genderTextField: TextField!
    @IBOutlet weak var relationTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var identifyTextField: TextField!
    @IBOutlet weak var insuranceTextField: TextField!
    @IBOutlet weak var addressTextField: TextField!
    @IBOutlet weak var overviewTextField: TextField!
    @IBOutlet weak var allergyHistoryTextField: TextField!
    @IBOutlet weak var medicalHistoryTextField: TextField!
    @IBOutlet weak var updateBurron: RaisedButton!
    
    internal var genderSelected: Gender!
    internal var relations: [String]!
    internal var relationSelected: PatientRelations!
    internal var patient: Patient!
    internal var indicator: SpringIndicator!
    internal var imageSelected: UIImage!
    internal var homecareService = HomeCaresService()
    
    // MARK: Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        initData()
        
    }
    
    // MARK: Intercal method
    
    internal func prepareUI() {
        avatarImageView.layer.cornerRadius = 25
        
        firstNameTextField.font = UIFont(name:"Montserrat-Light", size:15)
        middleNameTextField.font = UIFont(name:"Montserrat-Light", size:15)
        lastNameTextField.font = UIFont(name:"Montserrat-Light", size:15)
        birthdayTextField.font = UIFont(name:"Montserrat-Light", size:15)
        genderTextField.font = UIFont(name:"Montserrat-Light", size:15)
        relationTextField.font = UIFont(name:"Montserrat-Light", size:15)
        emailTextField.font = UIFont(name:"Montserrat-Light", size:15)
        phoneNumberTextField.font = UIFont(name:"Montserrat-Light", size:15)
        identifyTextField.font = UIFont(name:"Montserrat-Light", size:15)
        insuranceTextField.font = UIFont(name:"Montserrat-Light", size:15)
        addressTextField.font = UIFont(name:"Montserrat-Light", size:15)
        overviewTextField.font = UIFont(name:"Montserrat-Light", size:15)
        allergyHistoryTextField.font = UIFont(name:"Montserrat-Light", size:15)
        medicalHistoryTextField.font = UIFont(name:"Montserrat-Light", size:15)
        
        firstNameTextField.dividerNormalColor = .darkGray
        middleNameTextField.dividerNormalColor = .darkGray
        lastNameTextField.dividerNormalColor = .darkGray
        birthdayTextField.dividerNormalColor = .darkGray
        genderTextField.dividerNormalColor = .darkGray
        relationTextField.dividerNormalColor = .darkGray
        emailTextField.dividerNormalColor = .darkGray
        phoneNumberTextField.dividerNormalColor = .darkGray
        identifyTextField.dividerNormalColor = .darkGray
        insuranceTextField.dividerNormalColor = .darkGray
        addressTextField.dividerNormalColor = .darkGray
        overviewTextField.dividerNormalColor = .darkGray
        allergyHistoryTextField.dividerNormalColor = .darkGray
        medicalHistoryTextField.dividerNormalColor = .darkGray

        
        genderTextField.addRightImage("ic_arrow_down".image)
        relationTextField.addRightImage("ic_arrow_down".image)
        birthdayTextField.addRightImage("ic_arrow_down".image)
        relations = getRelationShip(of: "relationShip")
        
    }
    internal func getRelationShip(of key: String) -> [String] {
        if let url = Bundle.workRoster.url(forResource: "ServiceItem", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let dictionary = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
            
            let relates = dictionary?[key] as? [Any] {
            
            var menus = [String]()
            relates.forEach({ (value) in
                menus.append(value as! String)
            })
            return menus
        }
        return []
    }

    
    internal func initData() {
        if let url = URL(string: patient.avatar) {
            avatarImageView.af_setImage(
                withURL         : url,
                placeholderImage: "ic_user_default".image,
                imageTransition : .crossDissolve(0.2),
                completion: { response in
                    if let _ = response.result.error {
                        self.avatarImageView.image = "ic_user_default".image
                    }
            })
        } else {
            avatarImageView.image = "ic_user_default".image
        }
        detailLabel.text = patient.subInfor
        relationSelected = patient.patientRelations
        genderSelected = patient.gender
        firstNameTextField.text = patient.firstName
        middleNameTextField.text = patient.middleName
        lastNameTextField.text = patient.lastName
        emailTextField.text = patient.email
        relationTextField.text = relations[patient.patientRelations.rawValue]
        nameLabel.text = patient.firstName! + " " + patient.middleName! + " " + patient.lastName!
        birthdayTextField.text = patient.dateOfBirth.date(format: .dd_MM_yyyy)
        genderTextField.text = patient.gender! == .male ? "Male" : patient.gender! == .male ? "Female" : "Other"
        emailTextField.text = patient.email
        phoneNumberTextField.text = patient.phone
        addressTextField.text = patient.address
        medicalHistoryTextField.text = patient.medicalHistory
        allergyHistoryTextField.text = patient.allergyHistory
        overviewTextField.text = patient.healthOverview
        identifyTextField.text = patient.idCardNumber
        insuranceTextField.text = patient.insuranceNumber
    }
    
    internal func startWaiting() {
        indicator = SpringIndicator()
        indicator.lineWidth = 2
        indicator.lineColor = .white
        
        updateBurron.layout(indicator)
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
    
    internal func updatePatient() {
        if !emailTextField.text!.isEmpty, !emailTextField.text!.isValidEmail() {
            showAlert(title: "Notice", message: "Email unvalidate.", negativeTitle: "OK")
            return
        }
        if !phoneNumberTextField.text!.isEmpty, !phoneNumberTextField.text!.isValidatePhone() {
            showAlert(title: "Notice", message: "Phone number unvalidate.", negativeTitle: "OK")
            return
        }
        patient.firstName = firstNameTextField.text!
        patient.middleName = middleNameTextField.text!
        patient.lastName = lastNameTextField.text!
        if let date = DateHelper.shared.date(from: birthdayTextField.text!, format: .dd_MM_yyyy) {
            patient.dateOfBirth = "\(date)"
        }
        patient.gender = genderSelected
        patient.patientRelations = relationSelected
        patient.phone = phoneNumberTextField.text!
        patient.email = emailTextField.text!
        patient.address = addressTextField.text!
        patient.idCardNumber = identifyTextField.text!
        patient.healthOverview = overviewTextField.text!
        patient.medicalHistory = medicalHistoryTextField.text!
        patient.allergyHistory = allergyHistoryTextField.text!
        patient.insuranceNumber = insuranceTextField.text!
        patient.updated = "\(Date())"
        startWaiting()
        homecareService.updatePatient(patient: patient) {[weak self] (response) in
            guard let sSelf = self else { return }
            sSelf.stopWaiting()
            if let _ = response.data {
                sSelf.showSnackBar(message: "You updated successfully")
                if #available(iOS 10.0, *) {
                    let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                        sSelf.navigationController?.popViewController(animated: true)
                    })
                } else {
                    let _ = Timer.scheduledTimer(timeInterval: 1, target: sSelf, selector: #selector(sSelf.backToViewController), userInfo: nil, repeats: false)
                }
            } else if let error = response.error {
                sSelf.showAlert(title: "Error",
                                message: error.localizedDescription,
                                negativeTitle: "OK")
            }
        }
    }
    
    @objc
    internal func backToViewController() {
        navigationController?.popViewController(animated: true)
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
    
    @IBAction func updateMedicalBookAction(_ sender: Any) {
        updatePatient()
    }
    
    @IBAction func chooseGenderAction(_ sender: Any) {
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
    
    @IBAction func chooseBirthdayAction(_ sender: Any) {
        let date = DateHelper.shared.date(from: birthdayTextField.text!, format: .dd_MM_yyyy) ?? Date()
        let datePicker = ActionSheetDatePicker(title: "Ngày sinh", datePickerMode: .date, selectedDate: date, doneBlock: {
            _, value, index in
            if let date = value as? Date {
                self.birthdayTextField.text = "\(DateHelper.shared.string(from: date, format: .dd_MM_yyyy))"
            }
            
        }, cancel: { ActionStringCancelBlock in return }, origin: view)
        datePicker?.show()

    }
    @IBAction func chooseRelationAction(_ sender: Any) {
        
        let initialSelection = relations.index(of: relationTextField.text!) ?? 0
        let picker = ActionSheetStringPicker(title: "Mối quan hệ", rows: relations, initialSelection: initialSelection, doneBlock: { (_, index, value) in
            if let relate = value as? String {
                self.relationTextField.text = "\(relate)"
                self.relationSelected = PatientRelations(rawValue: index)!
            }
        }, cancel: { (_) in
            return
        }, origin: view)
        picker?.show()
    }
    
    @IBAction func chooseImageAction(_ sender: Any) {
        showAddImage()
    }
    
}

extension  ProfileViewController:  IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Information")
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    func handleSelectProfile() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let _ = info[UIImagePickerControllerReferenceURL] as? NSURL {
            let data = UIImagePNGRepresentation(image)!
            print("data    \(data)")
            homecareService.changePatientAvatar(patientId: patient.patientId, image: data, handler: { (_) in
                
            })
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
