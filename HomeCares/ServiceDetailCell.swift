//
//  ServiceDetailCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/8/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit


class ServiceDetailCell: UITableViewCell {
    
    // MARK: Property
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var overviewServiceLabel: UILabel!
    @IBOutlet weak var serviceDetailLabel: UILabel!
    
    // MARK: Override method
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Internal method
    
    internal func configure(service: ServiceItem) {
        serviceNameLabel.text = service.service.name
        overviewServiceLabel.text = service.service.overview
        serviceDetailLabel.text = service.service.detail
    }
    
    // MARK: Action
    
    @IBAction func registerAction(_ sender: Any) {
    }
    
}

