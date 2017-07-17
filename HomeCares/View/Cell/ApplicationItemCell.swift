//
//  ApplicationItemCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/13/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class ApplicationItemCell: TableViewCell {

    // MARK: Property
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    // MARK: Internal method
    
    internal func configure(option: OptionMenu) {
        backGroundView.layer.cornerRadius = 8
        backGroundView.layer.masksToBounds = true
        
        backGroundView.layer.masksToBounds = false
        backGroundView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        backGroundView.layer.shadowColor = UIColor.black.cgColor
        backGroundView.layer.shadowOpacity = 0.2
        backGroundView.layer.shadowRadius = 4
        iconImageView.image = option.image
        nameLabel.text = option.name
    }

}
