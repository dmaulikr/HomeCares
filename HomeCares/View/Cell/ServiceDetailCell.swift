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
    internal weak var delegate: ServiceDetailCellDelegate?
    internal var service: ServiceItem!
    
    // MARK: Override method
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Internal method
    
    internal func configure(service: ServiceItem) {
        self.service = service
        serviceNameLabel.text = service.service.name
        overviewServiceLabel.text = service.service.overview
        serviceDetailLabel.text = service.service.detail
    }
    
    // MARK: Action
    
    @IBAction func registerAction(_ sender: Any) {
        delegate?.didSelectRegisterService(service: service)
    }
    
}

protocol ServiceDetailCellDelegate: class{
    func didSelectRegisterService(service: ServiceItem)
}

