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
    
    internal var waitingView: UIView!
    internal var activityIndicator: UIActivityIndicatorView!
    
    
    internal var newButton: FABButton!
    internal let baseSize = CGSize(width: 52, height: 52)
    internal let bottomInset: CGFloat = 60
    internal let rightInset: CGFloat = 16
    internal var patients = [Patient]()
    internal var homeCareService = HomeCaresService()
    
    // MARK: Override method
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPatients()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMenuButton()
    
        tableView.clearSeparator()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150

    }
    
    // MARK: Internal method
    
    private func prepareMenuButton() {
        newButton = FABButton(image: Icon.cm.add, tintColor: .white)
        newButton.pulseColor = UIColor.white
        newButton.backgroundColor = UIColor.red
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
        guard let personId = UserDefaults.personId else { return }
        
        tableView.startHeaderLoading()
        homeCareService.getPatientsBy(personId: personId) { [weak self] (response) in
            guard let sSelf = self else {return}
            
            if let hasData = response.data {
                sSelf.patients = hasData
                sSelf.tableView.reloadData()
            }
            sSelf.tableView.stopHeaderLoading()
        }
    }
    
    internal func startWaiting() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        waitingView = UIView(frame: CGRect(x: 0, y: 0, width: window.bounds.width, height: window.bounds.height))
        waitingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        waitingView.layout(activityIndicator)
            .centerVertically()
            .centerHorizontally()
        activityIndicator.startAnimating()
        window.addSubview(waitingView)
    }
    
    internal func handleDeletePatient(patient: Patient, completion: @escaping (Bool) -> ()) {
        startWaiting()
        homeCareService.deletePatientsBy(id: patient.patientId) {
            [weak self] (response) in
            guard let sSelf = self else {return}
            sSelf.activityIndicator.stopAnimating()
            sSelf.waitingView.removeFromSuperview()
            if let _ = response.data {
                completion(true)
            } else {
                sSelf.showAlert(title: "Thông báo",
                          message: "Xoá sổ y bạ thất bại. Vui lòng thử lại sau.",
                          negativeTitle: "OK")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailPatientView" {
            if let vc = segue.destination as? PatientDetailViewController {
                vc.patient = sender as? Patient
            }
        }
        if segue.identifier == "ShowBookView" {
            if let vc = segue.destination as? ServiceBookingViewController {
                vc.patientSelected = sender as? Patient
            }
        }
    }

}

extension MedicalReportBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(
                title: "Chú ý",
                message: "Bạn có thực sự muốn xoá sổ y bạ này",
                negativeTitle: "Không", positiveTitle: "Có",
                positiveHandler: { _ in
                    self.handleDeletePatient(patient: self.patients[indexPath.row], completion: { (success) in
                        if success {
                            self.patients.remove(at: indexPath.row)
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    })
            })
        }
     }
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
        performSegue(withIdentifier: "ShowDetailPatientView", sender: patient)
    }
    
    func didSelectMakeAppointment(patient: Patient) {
        performSegue(withIdentifier: "ShowBookView", sender: patient)
    }
}
