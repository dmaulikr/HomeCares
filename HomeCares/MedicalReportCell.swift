//
//  MedicalReportCellTableViewCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import AlamofireImage

class MedicalReportCell: UITableViewCell {
    
    // MARK: Property
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameMemberLabel: UILabel!
    @IBOutlet weak var oldLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var relationLabel: UILabel!
    @IBOutlet weak var statusHealthLabel: UILabel!
    
    internal weak var delegate: MedicalReportCellDelegate?
    internal var patient: Patient!

    // MARK: Override method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 22.5
//        backGroundView.layer.masksToBounds = false
//        backGroundView.layer.cornerRadius = 3.0
//        backGroundView.layer.shadowOpacity = 0.8
//        backGroundView.layer.shadowRadius = 3.0
//        backGroundView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        backGroundView.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
        
    }
    
    // MARK: Internal method
    
    internal func configure(patient: Patient) {
        self.patient = patient
        if let url = URL(string: patient.avatar) {
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
        nameMemberLabel.text = "\(patient.firstName!) \(patient.middleName!) \(patient.lastName!)"
        switch patient.gender! {
        case .male:
            genderLabel.text = "Nam"
        case .female:
            genderLabel.text = "Nữ"
        default :
            genderLabel.text = "Khác"
        }
        relationLabel.text = getRelation(relation: patient.patientRelations)
        if let date = DateHelper.shared.date(from: patient.dateOfBirth, format: .yyyy_MM_dd_T_HH_mm_ss_Z) {
            oldLabel.text = "\(date.age) olds"
        }
        statusHealthLabel.text = patient.healthOverview!
    }
    
    internal func getRelation(relation: PatientRelations) -> String {
        switch relation {
        case .me:
            return "Me"
        case .son:
            return "Son"
        case .dauther:
            return "Dauther"
        case .father:
            return "Father"
        case .mother:
            return "Mother"
        case .fatherInLaw:
            return "Father in law"
        case .motherInlaw:
            return "Mother in law"
        case .grandFather:
            return "Grand father"
        case .grandMother:
            return "Grand mother"
        case .grandFatherInLaw:
            return "Grand father in law"
        case .grandMotherInLaw:
            return "Grand mother in law"
        case .elderBrother:
            return "Elder brother"
        case .elderSister:
            return "Elder sister"
        case .youngerBrother:
            return "Younger brother"
        case .youngerSister:
            return "Younger sister"
        case .elderBrotherInLaw:
            return "Elder brother in law"
        case .elderSisterInLaw:
            return "Elder sister in law"
        case .youngerBrotherInLaw:
            return "Younger brother in law"
        case .youngerSisterInlaw:
            return "Younger sister in law"
        case .neighbor:
            return "Neighbour"
        default:
            return "Other"
        }
    }
    
    // MARK: Action method

    @IBAction func viewProfileAction(_ sender: Any) {
        delegate?.didSelectViewFrofile(patient: patient)
    }
    
    @IBAction func makeAppointmentAction(_ sender: Any) {
        delegate?.didSelectMakeAppointment(patient: patient)
    }

}

protocol MedicalReportCellDelegate: class {
    func didSelectViewFrofile(patient: Patient)
    func didSelectMakeAppointment(patient: Patient)
}


