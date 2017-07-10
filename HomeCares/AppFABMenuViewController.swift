//
//  AppFABMenuViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/9/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class AppFABMenuViewController: FABMenuController {
    
    // MARK: Property
    
    private let baseSize = CGSize(width: 56, height: 56)
    private let itemSize = CGSize(width: 48, height: 48)
    private let bottomInset: CGFloat = 60
    private let rightInset: CGFloat = 16
    
    private lazy var menuButton: FABButton = {
        let menuButton = FABButton(image: Icon.cm.add, tintColor: .white)
        menuButton.pulseColor = UIColor.white
        menuButton.backgroundColor = UIColor.primary
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.shadowRadius = 1
        menuButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        menuButton.layer.shadowOpacity = 0.5
        return menuButton
    }()
    
    private lazy var newMessageMenuItem: FABMenuItem = {
        let menuItem = FABMenuItem()
        menuItem.fabButton.image = "ic_home".image
        menuItem.fabButton.tintColor = UIColor.white
        menuItem.fabButton.pulseColor = UIColor.white
        menuItem.fabButton.backgroundColor = UIColor.primary
        menuItem.fabButton.depthPreset = .depth1
        menuItem.title = "new_message"
        menuItem.layer.shadowColor = UIColor.black.cgColor
        menuItem.layer.shadowRadius = 1
        menuItem.layer.shadowOffset = CGSize(width: 1, height: 1)
        menuItem.layer.shadowOpacity = 0.5
        return menuItem
    }()
    
    private lazy var newGroupMenuItem: FABMenuItem = {
        let menuItem = FABMenuItem()
        menuItem.fabButton.image = "ic_add".image
        menuItem.fabButton.tintColor = UIColor.white
        menuItem.fabButton.pulseColor = UIColor.white
        menuItem.fabButton.backgroundColor = UIColor.primary
        menuItem.title = "new_group"
        menuItem.layer.shadowColor = UIColor.black.cgColor
        menuItem.layer.shadowRadius = 1
        menuItem.layer.shadowOffset = CGSize(width: 1, height: 1)
        menuItem.layer.shadowOpacity = 0.5
        return menuItem
    }()
    
       // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
   
    
    // MARK: Override method
    
    override func prepare() {
        super.prepare()
        
        prepareMenu()
    }
    

    @objc
    private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func prepareMenu() {
        view.layout(fabMenu)
            .size(baseSize)
            .bottom(bottomInset)
            .right(rightInset)
        
        fabMenu.delegate = self
        fabMenu.fabMenuItemSize = itemSize
        fabMenu.fabButton = menuButton
        fabMenu.fabMenuItems = [newMessageMenuItem, newGroupMenuItem]
    }
    
}

// MARK: FAMenuDelegate implementation

extension AppFABMenuViewController {
    
    func fabMenu(fabMenu: FABMenu, tappedAt point: CGPoint, isOutside: Bool) {
        guard isOutside else {
            return
        }
        fabMenu.close()
    }
    
    func fabMenuWillOpen(fabMenu: FABMenu) {
        fabMenu.fabButton?.motion(.rotationAngle(45))
    }
    
    func fabMenuWillClose(fabMenu: FABMenu) {
        fabMenu.fabButton?.motion(.rotationAngle(0))
    }
}



