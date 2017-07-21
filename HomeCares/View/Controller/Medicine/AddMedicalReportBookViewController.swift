//
//  AddMedicalReportBookViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/10/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material
import ActionSheetPicker_3_0
import SpringIndicator

class AddMedicalReportBookViewController: UIViewController {

    // MARK: Property
    
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var middleNameTextField: TextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var dateOfBirthTextField: TextField!
    @IBOutlet weak var genderTextField: TextField!
    @IBOutlet weak var relationshipTextField: TextField!
    @IBOutlet weak var addButton: Button!
    
    internal var relations: [String]!
    internal var genderSelected = Gender.female
    internal var relationSelected = PatientRelations.me
    
    internal var homecareService = HomeCaresService()
    internal var indicator: SpringIndicator!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        relationshipTextField.addRightImage("ic_arrow_down".image)
        genderTextField.addRightImage("ic_arrow_down".image)
        dateOfBirthTextField.addRightImage("ic_arrow_down".image)
        
        firstNameTextField.font = UIFont(name:"Montserrat-Light", size:15)
        middleNameTextField.font = UIFont(name:"Montserrat-Light", size:15)
        lastNameTextField.font = UIFont(name:"Montserrat-Light", size:15)
        dateOfBirthTextField.font = UIFont(name:"Montserrat-Light", size:15)
        genderTextField.font = UIFont(name:"Montserrat-Light", size:15)
        relationshipTextField.font = UIFont(name:"Montserrat-Light", size:15)
        
        firstNameTextField.dividerNormalColor = .darkGray
        middleNameTextField.dividerNormalColor = .darkGray
        lastNameTextField.dividerNormalColor = .darkGray
        dateOfBirthTextField.dividerNormalColor = .darkGray
        genderTextField.dividerNormalColor = .darkGray
        relationshipTextField.dividerNormalColor = .darkGray
        relations = getRelationShip(of: "relationShip")
        
        dateOfBirthTextField.text = "\(DateHelper.shared.string(from: Date(), format: .dd_MM_yyyy))"
        genderTextField.text = "Nữ"
        relationshipTextField.text = "Tôi"
        
    }
    
    internal func handleAddPatient() {
        if firstNameTextField.text!.isEmpty
        || middleNameTextField.text!.isEmpty
        || lastNameTextField.text!.isEmpty
        || dateOfBirthTextField.text!.isEmpty
        || genderTextField.text!.isEmpty
        || relationshipTextField.text!.isEmpty {
            showAlert(title: "Chú ý",
                      message: "Vui lòng điền đầy đủ thông tin.",
                      negativeTitle: "OK")
            return
        }
        
        guard  let personId = UserDefaults.personId else { return }
        
        let patient = Patient()
        patient.firstName = firstNameTextField.text!
        patient.middleName = middleNameTextField.text!
        patient.lastName = lastNameTextField.text!
        patient.dateOfBirth = dateOfBirthTextField.text!
        patient.healthOverview = "Sổ Y Bạ vừa được tạo, hãy cập nhật thông tin!"
        patient.gender = genderSelected
        patient.personId = personId
        patient.patientRelations = relationSelected
        patient.idCardNumber = ""
        patient.insuranceNumber = ""
        patient.avatar = ""
        patient.address = ""
        patient.phone = ""
        patient.latitude = 0
        patient.longitude = 0
        patient.created = "\(Date())"
        patient.updated = "\(Date())"
        patient.allergyHistory = ""
        patient.medicalHistory = ""
        patient.note = ""
        
        startWaiting()
        homecareService.addPatient(patient: patient) { [weak self](response ) in
            guard let sSelf = self else {return}
            
            sSelf.stopWaiting()
            if let _ = response.data {
                sSelf.navigationController?.popViewController(animated: true)
            }
        }
    
    }
    
    internal func startWaiting() {
        indicator = SpringIndicator()
        indicator.lineWidth = 2
        indicator.lineColor = .white
        
        addButton.layout(indicator)
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

    
    // MARK: Action
    
    @IBAction func choseDateOfBirthAction(_ sender: Any) {
        let date = DateHelper.shared.date(from: dateOfBirthTextField.text!, format: .dd_MM_yyyy) ?? Date()
        let datePicker = ActionSheetDatePicker(title: "Ngày sinh", datePickerMode: .date, selectedDate: date, doneBlock: {
            _, value, index in
            if let date = value as? Date {
                self.dateOfBirthTextField.text = "\(DateHelper.shared.string(from: date, format: .dd_MM_yyyy))"
            }
            
        }, cancel: { ActionStringCancelBlock in return }, origin: view)
        datePicker?.show()
    }
    
    @IBAction func choseGenderAction(_ sender: Any) {
        let gender = ["Nữ","Nam","Khác"]
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
    
    @IBAction func choseRelationshipsAction(_ sender: Any) {
        
        let initialSelection = relations.index(of: relationshipTextField.text!) ?? 0
        let picker = ActionSheetStringPicker(title: "Mối quan hệ", rows: relations, initialSelection: initialSelection, doneBlock: { (_, index, value) in
            if let relate = value as? String {
                self.relationshipTextField.text = "\(relate)"
                self.relationSelected = PatientRelations(rawValue: index)!
            }
        }, cancel: { (_) in
            return
        }, origin: view)
        picker?.show()

    }
    
    @IBAction func addPatientAction(_ sender: Any) {
        
        handleAddPatient()
    }
    
    
}
