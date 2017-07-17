//
//  ServiceMenuCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/7/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class ServiceMenuCell: UITableViewCell {
    
    // MARK: Property 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    internal var services: [ServiceItem]!
    internal weak var delegate: ServiceMenuCellDelegate?
    

    // MARK: Override method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        services = ServiceItem.getMenus(of: "serviceItem")
        
        collectionView.register(UINib.init(nibName: "ServiceItemCell", bundle: nil), forCellWithReuseIdentifier: "ServiceItemCell")
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 5
            let width = (UIScreen.main.bounds.width - 20) / 2
            layout.itemSize = CGSize(width: width, height: width)
        }
    }
}

extension ServiceMenuCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectServiceItem(service: services[indexPath.item])
    }
}

extension ServiceMenuCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceItemCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? ServiceItemCell)?.configure(service: services[indexPath.row])
    }
    
}

protocol ServiceMenuCellDelegate: class {
    func didSelectServiceItem(service: ServiceItem)
}
