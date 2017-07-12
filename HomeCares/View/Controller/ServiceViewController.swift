//
//  ServiceViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: Override method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowServiceDetail" {
            if let viewController = segue.destination as? ServiceDetailViewController {
                viewController.serviceItem = sender as? ServiceItem
            }
        }
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(UINib.init(nibName: "ServiceMenuCell", bundle: nil), forCellReuseIdentifier: "ServiceMenuCell")
    }

}

// MARK: UITableViewDelegate implementation

extension ServiceViewController: UITableViewDelegate {

}

// MARK: UITableViewDataSource implementation

extension ServiceViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceMenuCell", for: indexPath) as! ServiceMenuCell
            cell.delegate = self
            return cell
        }
    }

}

// MARK: ServiceMenuCellDelegate implementation

extension ServiceViewController: ServiceMenuCellDelegate {
    func didSelectServiceItem(service: ServiceItem) {
        performSegue(withIdentifier: "ShowServiceDetail", sender: service)
    }
}




