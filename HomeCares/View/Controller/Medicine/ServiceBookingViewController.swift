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
    
    internal var homecareService = HomeCaresService()
    internal var patientSelected: Patient!
    internal var patients:[Patient]!
    internal var peoples = [String]()
    internal var serviceSelected: ServiceItem!
    internal var serviceItems:[ServiceItem]!
    internal var services = [String]()

    // MARK: Liferecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        prepareData()
    }
    
    // MARK: Internal method
    
    internal func prepareData() {
        serviceItems = ServiceItem.getMenus(of: "serviceItem")
        services = serviceItems.map({$0.service.name})
        if patientSelected != nil {
            peopleUseServiceTextField.text = patientSelected.firstName + " " + patientSelected.middleName + " " + patientSelected.lastName
        }
        
        if serviceSelected != nil {
            typeServiceTextField.text = serviceSelected.service.name
        } else if let serviceDefault = services.first {
            typeServiceTextField.text = serviceDefault
        }
        
        homecareService.getPatientsBy(personId: 6) { [weak self] (response) in
            
            guard let sSelf = self else {return}
            
            if let hasData = response.data {
                sSelf.peoples = hasData.map({$0.firstName + " " + $0.middleName + " " + $0.lastName})
                sSelf.patients = hasData
            }
        }
    }
    
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
        var initialSelection = 0
        if peoples.isEmpty {return}
        if patientSelected != nil {
            if let index = peoples.index(where: {$0 == (self.patientSelected.firstName + " " + self.patientSelected.middleName + " " + self.patientSelected.lastName)}) {
                initialSelection = index
            }
        }
        let picker = ActionSheetStringPicker(title: "Ai sử dụng dịch vụ", rows: peoples, initialSelection: initialSelection, doneBlock: { (_, index, value) in
            if let people = value as? String {
                self.peopleUseServiceTextField.text = "\(people)"
                self.patientSelected = self.patients[index]
            }
        }, cancel: { (_) in
            return
        }, origin: view)
        picker?.show()

    }
    
    @IBAction func chooseTypeServiceAction(_ sender: Any) {
        if services.isEmpty {return}
        var initialSelection = 0
        if serviceSelected != nil {
            if let index = services.index(where: {$0 == serviceSelected.service.name}) {
                initialSelection = index
            }
         }
        let picker = ActionSheetStringPicker(title: "Loại dịch vụ", rows: services, initialSelection: initialSelection, doneBlock: { (_, index, value) in
            if let type = value as? String {
                self.typeServiceTextField.text = "\(type)"
                self.serviceSelected = self.serviceItems[index]
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
                self.timeTextField.text = "\(DateHelper.shared.string(from: date, format: .HH_mm_dd_MM_yyyy))"
            }
            
        }, cancel: { ActionStringCancelBlock in return }, origin: view)
        
        datePicker?.show()

    }

    @IBAction func confirmBookingAction(_ sender: Any) {
        if addressTextField.text!.isEmpty
            || phoneNumberTextField.text!.isEmpty
            || detailInfTextField.text!.isEmpty
            || timeTextField.text!.isEmpty
            || peopleUseServiceTextField.text!.isEmpty {
            showAlert(title: "Notice",
                      message: "Please fill in information",
                      negativeTitle: "OK")
            return
        }
        
        guard let personId = UserDefaults.personId,
                let email = UserDefaults.email
        else { return }
        let order = Order()
        order.personId = personId
        order.email = email
        order.address = addressTextField.text!
        order.phone = phoneNumberTextField.text!
        order.information = detailInfTextField.text!
        order.patientId = patientSelected.patientId
        order.price = 0
        order.longitude = 0.1
        order.latitude = 0.1
        order.updated = "\(Date())"
        order.created = "\(Date())"
        order.bookingTime = timeTextField.text!
        
        homecareService.addOrder(order: order) { [weak self] (response) in
            guard let sSelf = self else { return }
            
            if let _ = response.data {
                sSelf.showSnackBar(message: "You booked service successfully")
                let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                    sSelf.navigationController?.popViewController(animated: true)
                })
            } else if let error = response.error {
                sSelf.showAlert(title: "Error",
                                message: error.localizedDescription,
                                negativeTitle: "OK")
            }
            
        }
    }
}
