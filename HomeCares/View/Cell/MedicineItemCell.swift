//
//  MedicineItemCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/16/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import Material

class MedicineItemCell: TableViewCell {
    
    // MARK: Property
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var medicineNameLabel: UILabel!
    @IBOutlet weak var medicineNote: UILabel!
    @IBOutlet weak var medicineOverview: UILabel!
    internal var medicine: Medicine!
    internal var indexPath: IndexPath!
    internal var disease: Disease!
    
    // MARK: Internal method
    
    internal func configure(medicine: Medicine, indexPath: IndexPath) {
        backGroundView.layer.cornerRadius = 5
        backGroundView.layer.masksToBounds = false
        backGroundView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        backGroundView.layer.shadowColor = UIColor.black.cgColor
        backGroundView.layer.shadowOpacity = 0.2
        backGroundView.layer.shadowRadius = 2
        iconImageView.backgroundColor = UIColor.random
        numberLabel.text = "\(indexPath.row + 1)"
        medicineNameLabel.text = medicine.name
        medicineOverview.text = medicine.medicineGroups.groupName
        
        if let country = medicine.countryRegister, !country.isEmpty {
            medicineNote.text = "Medicine of \(country.replacingOccurrences(of: "\n", with: "").trimmed)"
            return
        }
        if let company = medicine.companyRegister, !company.replacingOccurrences(of: "\n", with: "").isEmpty {
            medicineNote.text = "Company of medicine : \(company.replacingOccurrences(of: "\n", with: "").trimmed)"
            return
        }
        if let regCode = medicine.registerCode, !regCode.replacingOccurrences(of: "\n", with: "").isEmpty {
            medicineNote.text = "Register code : " + regCode.replacingOccurrences(of: "\n", with: "").trimmed
            return
        }
        if let longLive = medicine.longevity, !longLive.replacingOccurrences(of: "\n", with: "").isEmpty {
            medicineNote.text = "Longlive : " + longLive.replacingOccurrences(of: "\n", with: "").trimmed
            return
        }
    }
    
    
}
