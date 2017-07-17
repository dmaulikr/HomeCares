//
//  BlogHeaderCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/8/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class BlogHeaderCell: TableViewCell {
    
    // MARK: Property
    
    @IBOutlet weak var titleBlogLabel: UILabel!
    @IBOutlet weak var timeBlogLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var describeLabel: UILabel!
    
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Internal method
    
    internal func configure(blog: Blog) {
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = self.bounds
//        gradient.colors = [UIColor.white.cgColor,UIColor.white.cgColor, UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
//        backGroundView.layer.insertSublayer(gradient, at: 0)
        describeLabel.text = blog.descriptionBlog
        titleBlogLabel.text = blog.title
        timeBlogLabel.text = blog.created.date(format: .HH_mm_ss_EEE_dd_LLL_yyyy)
    }
}
