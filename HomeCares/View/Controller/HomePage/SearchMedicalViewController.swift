//
//  SearchMedicalViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/9/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class SearchMedicalViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    internal let searchBars = UISearchBar()
    internal var medicines = [Medicine]()
    internal var homecareService = HomeCaresService()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMedicines()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        self.navigationItem.titleView = searchBars
        searchBars.placeholder = "Search medicine"
        searchBars.showsCancelButton = false
        searchBars.delegate = self
        searchBars.enablesReturnKeyAutomatically = true
    }
    
    // MARK: Internal method
    
    internal func getMedicines() {
        tableView.startHeaderLoading()
        homecareService.getMedicines { [weak self] (response) in
            
            guard let sSelf = self else {return}
            sSelf.tableView.stopHeaderLoading()
            if let hasData = response.data {
                sSelf.medicines = hasData
                sSelf.tableView.reloadData()
            }
        }
    }
    internal func getMedicinesBy(key: String) {
        homecareService.getMedicines(key: key) { [weak self] (response) in
            
            guard let sSelf = self else {return}
            if let hasData = response.data {
                sSelf.medicines = hasData
                sSelf.tableView.reloadData()
            }
        }
    }
    
    internal func openDetailMedicine(medicine: Medicine) {
        performSegue(withIdentifier: "ShowDetailMedicineView", sender: medicine)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailMedicineView" {
            if let vc = segue.destination as? MedicineDetailViewController {
                vc.medicine = sender as! Medicine
            }
        }
    }

}

extension SearchMedicalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailMedicine(medicine: medicines[indexPath.row])
    }

}

extension SearchMedicalViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineItemCell", for: indexPath) as! MedicineItemCell
        cell.configure(medicine: medicines[indexPath.row], indexPath: indexPath)
        return cell
    }
}

extension SearchMedicalViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil, !searchBar.text!.isEmpty {
            getMedicinesBy(key: searchBar.text!)
        } else {
            tableView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
