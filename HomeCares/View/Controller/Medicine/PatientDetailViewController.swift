//
//  PatientTabbarViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/18/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class PatientDetailViewController: ButtonBarPagerTabStripViewController {
    
    internal var patient: Patient!
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        guard let profileVC = UIStoryboard.init(name: "MedicalReport", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController,
            let notesVC = UIStoryboard.init(name: "MedicalReport", bundle: nil).instantiateViewController(withIdentifier: "NotesPatientViewController") as? NotesPatientViewController else { return []}
        profileVC.patient = patient
        notesVC.patient = patient
        return [profileVC,notesVC]
    }
    
    override func viewDidLoad() {
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemTitleColor = UIColor.darkGray
        settings.style.selectedBarHeight = 2
        settings.style.selectedBarBackgroundColor = UIColor.pink
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.buttonBarItemFont = UIFont(name:"Montserrat-Regular", size:18) ?? UIFont.systemFont(ofSize: 18)
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        super.viewDidLoad()
        
        title = "PATIENT DETAIL"
    }
    
}
