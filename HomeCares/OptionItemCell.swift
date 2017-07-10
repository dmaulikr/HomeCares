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
    
    // MARK: Internal method
    
    internal func configure(optionMenu: OptionMenu) {
        imageImageView.image = optionMenu.image
        nameLabel.text = optionMenu.name
    }

}
