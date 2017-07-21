//
//  DiseaseCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/21/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import Material

class DiseaseCell: TableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    internal func configure(disease: Disease, indexPath: IndexPath) {
        backGroundView.layer.cornerRadius = 5
        backGroundView.layer.masksToBounds = false
        backGroundView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        backGroundView.layer.shadowColor = UIColor.black.cgColor
        backGroundView.layer.shadowOpacity = 0.2
        backGroundView.layer.shadowRadius = 2
        iconImageView.backgroundColor = UIColor.random
        numberLabel.text = "\(indexPath.row + 1)"
        nameLabel.text = disease.name.replacingOccurrences(of: "\n", with: "").trimmed
        detailLabel.text = disease.summary.replacingOccurrences(of: "\n", with: "").trimmed
    }
}
