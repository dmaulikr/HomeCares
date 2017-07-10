//
//  HomeItemCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/8/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material
import AlamofireImage

class BlogCell: TableViewCell {

    // MARK: Property
    @IBOutlet weak var titleBlogLabel: UILabel!
    @IBOutlet weak var timeBlockLabel: UILabel!
    @IBOutlet weak var imageLinkBlogLabel: UIImageView!
    
    @IBOutlet weak var describeLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Internal method
    
    internal func configure(blog: Blog) {
        titleBlogLabel.text = blog.title
        timeBlockLabel.text = blog.created.date(format: .HH_mm_ss_EEE_dd_LLL_yyyy)
        describeLabel.text = blog.descriptionBlog
        if let url = URL(string: blog.imageLink) {            
            imageLinkBlogLabel.af_setImage(withURL: url,
                placeholderImage: "ic_user_default".image,
                imageTransition: .crossDissolve(0.2),
                completion: { (response) in
                    if let _ = response.result.error {
                        self.imageLinkBlogLabel.image = "ic_user_default".image
                    }
            })
        } else {
            imageLinkBlogLabel.image = "ic_user_default".image
        }
    }
}
