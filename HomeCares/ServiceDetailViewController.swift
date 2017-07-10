//
//  ServiceDetailViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/7/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class ServiceDetailViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    internal var serviceItem: ServiceItem!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        if let serviceItem = serviceItem {
            title = serviceItem.service.name
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        tableView.register(UINib.init(nibName: "ServiceDetailCell", bundle: nil), forCellReuseIdentifier: "ServiceDetailCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: UITableViewDelegate implementation

extension ServiceDetailViewController: UITableViewDelegate {
    
}

// MARK: UITableViewDataSource implementation

extension ServiceDetailViewController: UITableViewDataSource {
    
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
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceDetailCell", for: indexPath) as! ServiceDetailCell
            cell.configure(service: serviceItem)
            return cell
        }
    }
    
}
