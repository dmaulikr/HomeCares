//
//  ServiceItemCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/7/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material
class ServiceItemCell: CollectionViewCell {
    
    // MARK: Property
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    
    // MARK: Override method

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.tintColor = UIColor.white
    }
    
    // MARK: Internal method
    
    internal func configure(service: ServiceItem) {
        iconImageView.image = service.icon
        serviceNameLabel.text = service.service.name
        backGroundView.backgroundColor = service.backGroundColor
    }

}
