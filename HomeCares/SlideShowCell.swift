//
//  SlideShowCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/8/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import ImageSlideshow

class SlideShowCell: UITableViewCell {
    
    // MARK: Property
    
    
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    
    internal var localSource = [ImageSource(imageString: "app_service")!, ImageSource(imageString: "app_service")!, ImageSource(imageString: "app_service")!, ImageSource(imageString: "app_service")!]
    
    // MARK: Override method

    override func awakeFromNib() {
        super.awakeFromNib()
        initializeImageSlideshow()
    }
    
    // MARK: Internal method
    
    internal func initializeImageSlideshow() {
        imageSlideshow.backgroundColor = .white
        imageSlideshow.slideshowInterval = 4.0
        imageSlideshow.pageControlPosition = .insideScrollView
        imageSlideshow.pageControl.currentPageIndicatorTintColor = .black
        imageSlideshow.pageControl.pageIndicatorTintColor = .lightGray
        imageSlideshow.contentScaleMode = .scaleAspectFill
        
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        imageSlideshow.currentPageChanged = { page in
            
        }
        
        imageSlideshow.setImageInputs(localSource)
    }


}
