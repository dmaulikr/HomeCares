//
//  ServiceBookingViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/5/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material
import ActionSheetPicker_3_0

class ServiceBookingViewController: UIViewController {
    
    // MARK: Property
    @IBOutlet weak var peopleUseServiceTextField: TextField!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var typeServiceTextField: TextField!
    @IBOutlet weak var addressTextField: TextField!
    @IBOutlet weak var detailInfTextField: TextField!
    @IBOutlet weak var timeTextField: TextField!
    
    @IBOutlet weak var peopleUseServiceButton: UIButton!
    @IBOutlet weak var typeServiceButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    
    internal var patient: Patient!
    internal var peoples = ["Nguyen Van A", "Nguyen Van B"]
    internal var types = ["Service A", "Service B"]

    // MARK: Liferecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        
        peopleUseServiceTextField.addRightImage("ic_arrow_down".image)
        typeServiceTextField.addRightImage("ic_arrow_down".image)
        timeTextField.addRightImage("ic_arrow_down".image)
        
        timeTextField.font = UIFont(name:"Montserrat-Light", size:16)
        typeServiceTextField.font = UIFont(name:"Montserrat-Light", size:16)
        peopleUseServiceTextField.font = UIFont(name:"Montserrat-Light", size:16)
        phoneNumberTextField.font = UIFont(name:"Montserrat-Light", size:16)
        addressTextField.font = UIFont(name:"Montserrat-Light", size:16)
        detailInfTextField.font = UIFont(name:"Montserrat-Light", size:16)
    }
    
    // MARK: Action
    
    @IBAction func choosePeopleAction(_ sender: Any) {
        let picker = ActionSheetStringPicker(title: "Ai sử dụng dịch vụ", rows: peoples, initialSelection: 0, doneBlock: { (_, index, value) in
            if let people = value as? String {
                self.peopleUseServiceTextField.text = "\(people)"
            }
        }, cancel: { (_) in
            return
        }, origin: view)
        picker?.show()

    }
    
    @IBAction func chooseTypeServiceAction(_ sender: Any) {
        let picker = ActionSheetStringPicker(title: "Loại dịch vụ", rows: types, initialSelection: 0, doneBlock: { (_, index, value) in
            if let type = value as? String {
                self.typeServiceTextField.text = "\(type)"
            }
        }, cancel: { (_) in
            return
        }, origin: view)
        picker?.show()

    }
    
    @IBAction func chooseTimeAction(_ sender: Any) {
        
        let datePicker = ActionSheetDatePicker(title: "Thời gian", datePickerMode: UIDatePickerMode.dateAndTime, selectedDate: Date(), doneBlock: {
            _, value, index in
            if let date = value as? Date {
                self.timeTextField.text = "\(date)"
            }
            
        }, cancel: { ActionStringCancelBlock in return }, origin: view)
        
        datePicker?.show()

    }

}
