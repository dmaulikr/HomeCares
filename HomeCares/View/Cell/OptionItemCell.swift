//
//  OptionItemCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/8/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class OptionItemCell: CollectionViewCell {
    
    // MARK: Property
    
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    // MARK: Internal method
    
    internal func configure(optionMenu: OptionMenu) {
        backGroundView.layer.masksToBounds = false
        backGroundView.layer.cornerRadius = 4.0
        backGroundView.layer.shadowOpacity = 0.8
        backGroundView.layer.shadowRadius = 2.0
        backGroundView.layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
        backGroundView.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
        imageImageView.image = optionMenu.image
        nameLabel.text = optionMenu.name
    }

}
