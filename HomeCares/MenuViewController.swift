/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import Material

protocol MenuDelegate: class {
    
    func onDidSelectAddNewMember()
    
    func onDidSelectMakeAppointment()
    
}

class MenuViewController: FABMenuController {
    
    // MARK: Property
    
    private let baseSize = CGSize(width: 56, height: 56)
    private let bottomInset: CGFloat = 16
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
    
    private lazy var addNewMember: FABMenuItem = {
        let menuItem = FABMenuItem()
        menuItem.fabButton.image = "ic_add".image
        menuItem.fabButton.tintColor = UIColor.white
        menuItem.fabButton.pulseColor = UIColor.white
        menuItem.fabButton.backgroundColor = UIColor.primary
        menuItem.fabButton.depthPreset = .depth1
        menuItem.title = "New member"
        menuItem.layer.shadowColor = UIColor.black.cgColor
        menuItem.layer.shadowRadius = 1
        menuItem.layer.shadowOffset = CGSize(width: 1, height: 1)
        menuItem.layer.shadowOpacity = 0.5
        return menuItem
    }()
    
    private lazy var makeAppointment: FABMenuItem = {
        let menuItem = FABMenuItem()
        menuItem.fabButton.image = "ic_list".image
        menuItem.fabButton.tintColor = UIColor.white
        menuItem.fabButton.pulseColor = UIColor.white
        menuItem.fabButton.backgroundColor = UIColor.primary
        menuItem.title = "Make appointment"
        menuItem.layer.shadowColor = UIColor.black.cgColor
        menuItem.layer.shadowRadius = 1
        menuItem.layer.shadowOffset = CGSize(width: 1, height: 1)
        menuItem.layer.shadowOpacity = 0.5
        return menuItem
    }()
    
    
    internal weak var delegate: MenuDelegate?
    
    
    // MARK: Override method
    
    override func prepare() {
        super.prepare()
        prepareMenu()
    }
    
    // MARK: Private method
    
    private func prepareMenu() {
        view.layout(fabMenu)
            .size(baseSize)
            .bottom(bottomInset)
            .right(rightInset)
        
        fabMenu.delegate = self
        fabMenu.fabMenuItemSize = baseSize
        fabMenu.fabButton = menuButton
        fabMenu.fabMenuItems = [addNewMember, makeAppointment]
    }
    
}

// MARK: FAMenuDelegate implementation

extension MenuViewController {
    
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


