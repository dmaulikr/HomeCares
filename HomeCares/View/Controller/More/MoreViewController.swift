//
//  MoreViewController.swift
//  
//
//  Created by Tuat Tran on 7/13/17.
//
//

import UIKit

class MoreViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    internal var menus = [OptionMenu]()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        prepareData()
    }
    
    // MARK: Internal method
    
    internal func prepareData() {
        menus = OptionMenu.getMenus(of: "application")
        avatarImageView.layer.cornerRadius = 30
        
        if let avatar = UserDefaults.avatar, let url = URL(string: avatar) {
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
        nameLabel.text = UserDefaults.nameUser!
    }
    
    internal func prepareUI() {
        tableView.clearSeparator()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: Action
    
    @IBAction func settingAction(_ sender: Any) {
        
        
    }
    

}

extension MoreViewController : UITableViewDelegate {
   
}

extension MoreViewController : UITableViewDataSource {
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationItemCell", for: indexPath) as! ApplicationItemCell
        cell.configure(option: menus[indexPath.row])
        return cell
    }

}
