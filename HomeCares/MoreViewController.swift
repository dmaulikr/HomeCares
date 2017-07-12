//
//  MoreViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK:Internal method
    
    internal func prepareUI() {
        if let avatar =  UserDefaults.avatar, let url = URL(string: avatar) {
            avatarImageView.af_setImage(
                withURL         : url,
                placeholderImage: "ic_user_default".image,
                imageTransition : .crossDissolve(0.2),
                completion: { (response) in
                    if let _  = response.result.error {
                        self.avatarImageView.image = "ic_user_default".image
                    }
            })
        } else {
            avatarImageView.image = "ic_user_default".image
        }
        nameLabel.text = "Xin chào " + UserDefaults.nameUser!
    
    }
    
    // MARK: Action
    
    @IBAction func editAccountAction(_ sender: Any) {
    }
    
    @IBAction func detailAccountAction(_ sender: Any) {
    }

}

extension MoreViewController: UITableViewDelegate {
    
}

extension MoreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath)
        return cell
    }
}
