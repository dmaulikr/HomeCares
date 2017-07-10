//
//  TextField.swift
//  WorkRoster
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//
import UIKit

extension UITextField {
    
    public func addLeftImage(_ image: UIImage?) {
        let frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        
        leftView = UIImageView(image: image)
        leftView?.frame = frame
        leftView?.contentMode = .center
        leftView?.tintColor = UIColor.black
        leftViewMode = .always
        layoutIfNeeded()
    }
    
    public func addRightImage(_ image: UIImage?) {
        let frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        
        rightView = UIImageView(image: image)
        rightView?.frame = frame
        rightView?.tintColor = UIColor.black
        rightViewMode = .always
    }
    
}
