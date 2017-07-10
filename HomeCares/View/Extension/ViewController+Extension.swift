//
//  ViewController+Extension.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func showAlert(
        title           : String,
        message         : String,
        negativeTitle   : String,
        negativeHandler : ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: negativeTitle, style: .cancel, handler: negativeHandler))
        showDetailViewController(alertController, sender: nil)
    }

}