//
//  OptionMenuCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/8/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class OptionMenuCell: UITableViewCell {

    // MARK: Property
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    internal var optionMenus: [OptionMenu]!
    internal weak var delegate: OptionMenuCellDelegate?
    
    // MARK: Override method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        optionMenus = OptionMenu.getMenus(of: "optionMenu")
        self.collectionView.register(UINib.init(nibName: "OptionItemCell", bundle: nil), forCellWithReuseIdentifier: "OptionItemCell")
        self.collectionView.isScrollEnabled = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            let width = (UIScreen.main.bounds.width - 10) / 2
            layout.itemSize = CGSize(width: width, height: 40)
        }
    }
}

extension OptionMenuCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "OptionItemCell", for: indexPath) as! OptionItemCell
        cell.configure(optionMenu: optionMenus[indexPath.item])
        return cell
    }
}

extension OptionMenuCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMenuItem(menu: optionMenus[indexPath.row])
    }
}

protocol OptionMenuCellDelegate: class {
    func didSelectMenuItem(menu: OptionMenu)
}
