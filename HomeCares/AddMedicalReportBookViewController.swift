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

class AddMedicalReportBookViewController: UIViewController {

    // MARK: Property
    
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var middleNameTextField: TextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var dateOfBirthTextField: TextField!
    @IBOutlet weak var genderTextField: TextField!
    @IBOutlet weak var relationshipTextField: TextField!
    
    internal var relations: [String]!
    
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
        
        firstNameTextField.font = UIFont(name:"Montserrat-Light", size:16)
        middleNameTextField.font = UIFont(name:"Montserrat-Light", size:16)
        lastNameTextField.font = UIFont(name:"Montserrat-Light", size:16)
        dateOfBirthTextField.font = UIFont(name:"Montserrat-Light", size:16)
        genderTextField.font = UIFont(name:"Montserrat-Light", size:16)
        relationshipTextField.font = UIFont(name:"Montserrat-Light", size:16)
        
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
        let gender = ["Female","Male"]
        let initialSelection = gender.index(of: genderTextField.text!) ?? 0
        let picker = ActionSheetStringPicker(title: "Giới tính", rows: gender, initialSelection: initialSelection, doneBlock: { (_, index, value) in
            if let gen = value as? String {
                self.genderTextField.text = "\(gen)"
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
            }
        }, cancel: { (_) in
            return
        }, origin: view)
        picker?.show()

    }
    
}
