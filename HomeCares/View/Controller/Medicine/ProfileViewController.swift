//
//  ProfileViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/5/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthDayLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var medialHistoryLabel: UILabel!
    @IBOutlet weak var ellergyHistoryLabel: UILabel!
    
    internal var patient: Patient!
    
    // MARK: Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        initData()
        
    }
    
    // MARK: Intercal method
    
    internal func prepareUI() {
        avatarImageView.layer.cornerRadius = 25
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
        
        nameLabel.text = "\(patient.firstName!) \(patient.middleName!) \(patient.lastName!)"
        birthDayLabel.text = patient.dateOfBirth.date(format: .dd_MM_yyyy)
        genderLabel.text = patient.gender! == .male ? "Male" : "Female"
        emailLabel.text = !patient.email.isEmpty ?  patient.email : " "
        phoneNumberLabel.text = !patient.phone.isEmpty ? patient.phone : " "
        addressLabel.text = !patient.address.isEmpty ? patient.address : " "
        medialHistoryLabel.text = !patient.medicalHistory.isEmpty ? patient.medicalHistory : " "
        ellergyHistoryLabel.text = !patient.allergyHistory.isEmpty ? patient.allergyHistory : " "
    }
}
