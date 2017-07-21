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
import MapKit
import SpringIndicator
import MJSnackBar
import CoreLocation

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
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var confirmButton: Button!
    internal var homecareService = HomeCaresService()
    internal var patientSelected: Patient!
    internal var patients:[Patient]!
    internal var peoples = [String]()
    internal var serviceSelected: ServiceItem!
    internal var serviceItems:[ServiceItem]!
    internal var services = [String]()
    internal var indicator: SpringIndicator!
    internal var locationManager: CLLocationManager!

    // MARK: Liferecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        prepareData()
        setUpLocation()
    }
    
    // MARK: Internal method
    internal func setUpLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    internal func prepareData() {
        serviceItems = ServiceItem.getMenus(of: "serviceItem")
        services = serviceItems.map({$0.service.name})
        
        
        if serviceSelected != nil {
            typeServiceTextField.text = serviceSelected.service.name
        } else if let serviceDefault = services.first {
            typeServiceTextField.text = serviceDefault
        }
        if let personId = UserDefaults.personId {
            homecareService.getPatientsBy(personId: personId) { [weak self] (response) in
                guard let sSelf = self else {return}
                if let hasData = response.data {
                    sSelf.peoples = hasData.map({$0.firstName + " " + $0.middleName + " " + $0.lastName})
                    sSelf.patients = hasData
                    if sSelf.patientSelected == nil, !hasData.isEmpty {
                       sSelf.patientSelected = hasData.first!
                       sSelf.peopleUseServiceTextField.text = sSelf.patientSelected.firstName + " " + sSelf.patientSelected.middleName + " " + sSelf.patientSelected.lastName
                    }
                }
            }
        }
        
        if patientSelected != nil {
            peopleUseServiceTextField.text = patientSelected.firstName + " " + patientSelected.middleName + " " + patientSelected.lastName
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
    
    internal func startWaiting() {
        indicator = SpringIndicator()
        indicator.lineWidth = 2
        indicator.lineColor = .white
        
        confirmButton.layout(indicator)
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
        if let date = DateHelper.shared.date(from: timeTextField.text!, format: .HH_mm_dd_MM_yyyy) {
            order.bookingTime = DateHelper.shared.string(from: date, format: .yyyy_MM_dd_T_HH_mm_ss_Z)
        }
        
        startWaiting()
        homecareService.addOrder(order: order) { [weak self] (response) in
            guard let sSelf = self else { return }
            
            sSelf.stopWaiting()
            if let _ = response.data {
                sSelf.showSnackBar(message: "You booked service successfully")
                if #available(iOS 10.0, *) {
                    let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                        sSelf.navigationController?.popViewController(animated: true)
                    })
                } else {
                    let _ = Timer.scheduledTimer(timeInterval: 1, target: sSelf, selector: #selector(sSelf.backToVC), userInfo: nil, repeats: false)
                }
            } else if let error = response.error {
                sSelf.showAlert(title: "Error",
                                message: error.localizedDescription,
                                negativeTitle: "OK")
            }
            
        }
    }
    
    @objc
    internal func backToVC() {
        navigationController?.popViewController(animated: true)
    }
}

extension ServiceBookingViewController: CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
    
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
        mapView.setRegion(region, animated: true)
    }
}
