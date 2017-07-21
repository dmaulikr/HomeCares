//
//  SearchDiseaseViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/9/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class SearchDiseaseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    internal let searchBars = UISearchBar()
    internal var diseases = [Disease]()
    internal var homecareService = HomeCaresService()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDiseases()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        self.navigationItem.titleView = searchBars
        searchBars.placeholder = "Tìm kiếm bệnh"
        searchBars.showsCancelButton = false
        searchBars.delegate = self
        searchBars.enablesReturnKeyAutomatically = true
    }
    
    // MARK: Internal method
    
    internal func getDiseases() {
        tableView.startHeaderLoading()
        homecareService.getDisease { [weak self] (response) in
            
            guard let sSelf = self else {return}
            sSelf.tableView.stopHeaderLoading()
            if let hasData = response.data {
                sSelf.diseases = hasData
                sSelf.tableView.reloadData()
            }
        }
    }
    internal func getDiseasesBy(key: String) {
        homecareService.getDisease(key: key) { [weak self] (response) in
            
            guard let sSelf = self else {return}
            if let hasData = response.data {
                sSelf.diseases = hasData
                sSelf.tableView.reloadData()
            }
        }
    }
    
    internal func openDetailMedicine(diseases: Disease) {
        performSegue(withIdentifier: "ShowDetailDiseaseView", sender: diseases)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailDiseaseView" {
            if let vc = segue.destination as? DiseaseDetailViewController {
                vc.disease = sender as! Disease
            }
        }
    }
}

extension SearchDiseaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailMedicine(diseases: diseases[indexPath.row])
    }
    
}

extension SearchDiseaseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diseases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseCell", for: indexPath) as! DiseaseCell
        cell.configure(disease: diseases[indexPath.row], indexPath: indexPath)
        return cell
    }
}

extension SearchDiseaseViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil, !searchBar.text!.isEmpty {
            getDiseasesBy(key: searchBar.text!)
        } else {
            tableView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
