//
//  MedicalReportBookViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class MedicalReportBookViewController: UIViewController {

    // MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    
    internal var newButton: FABButton!
    internal let baseSize = CGSize(width: 56, height: 56)
    internal let bottomInset: CGFloat = 60
    internal let rightInset: CGFloat = 16
    internal var patients = [Patient]()
    internal var homeCareService = HomeCaresService()
    
    // MARK: Override method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMenuButton()
        getPatients()
        tableView.clearSeparator()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150

    }
    
    // MARK: Internal method
    
    private func prepareMenuButton() {
        newButton = FABButton(image: Icon.cm.add, tintColor: .white)
        newButton.pulseColor = UIColor.white
        newButton.backgroundColor = UIColor.primary
        newButton.layer.shadowColor = UIColor.black.cgColor
        newButton.layer.shadowRadius = 1
        newButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        newButton.layer.shadowOpacity = 0.5
        
        view.layout(newButton)
            .size(baseSize)
            .bottom(bottomInset)
            .right(rightInset)
        
        newButton.addTarget(self, action: #selector(openAddViewController), for: .touchUpInside)
    }
    
    @objc
    internal func openAddViewController() {
        performSegue(withIdentifier: "ShowAddMedical", sender: nil)
    }
    
    internal func getPatients() {
        tableView.startHeaderLoading()
        homeCareService.getPatients(id: 6) { [weak self] (response) in
            guard let sSelf = self else {return}
            
            if let hasData = response.data {
                sSelf.patients = hasData
                sSelf.tableView.reloadData()
            }
            sSelf.tableView.stopHeaderLoading()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProfileView" {
            if let vc = segue.destination as? ProfileViewController {
                vc.patient = sender as? Patient
            }
        }
        if segue.identifier == "ShowBookView" {
            if let vc = segue.destination as? ServiceBookingViewController {
                vc.patient = sender as? Patient
            }
        }
    }

}

extension MedicalReportBookViewController: UITableViewDelegate {
    
}

extension MedicalReportBookViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalReportCell") as! MedicalReportCell
        cell.configure(patient: patients[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension MedicalReportBookViewController: MedicalReportCellDelegate {
    
    func didSelectViewFrofile(patient: Patient) {
        performSegue(withIdentifier: "ShowProfileView", sender: patient)
    }
    
    func didSelectMakeAppointment(patient: Patient) {
        performSegue(withIdentifier: "ShowBookView", sender: patient)
    }
}
