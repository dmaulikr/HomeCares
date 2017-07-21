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
    internal var userPerson: UserPerson!
    internal var homecareService = HomeCaresService()
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserPerson()
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        menus = OptionMenu.getMenus(of: "application")
    }
    
    // MARK: Internal method
    

    internal func getUserPerson() {
        guard let userId = UserDefaults.userId else {
            return
        }
        homecareService.getUserPersonBy(userId: userId) { [weak self] (response) in
            guard let sSelf = self else { return }
            
            if let data = response.data {
                sSelf.userPerson = data
                sSelf.bindData()
            }
            
            if let error = response.error {
                sSelf.showAlert(title: "Error", message: error.localizedDescription, negativeTitle: "OK")
            }
        }
    }
    
    internal func bindData() {
       
        avatarImageView.layer.cornerRadius = 30
        
        if let url = URL(string: userPerson.avatar) {
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
        nameLabel.text = "Welcome \(userPerson.firstName!)"
        detailLabel.text = "Your account have \(userPerson.balances!) VND."
    }
    
    internal func prepareUI() {
        tableView.clearSeparator()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAccountView" {
            if let vc = segue.destination as? AccountViewController {
                vc.userPerson = sender as? UserPerson
            }
        }
    }
    
    // MARK: Action
    
    @IBAction func settingAction(_ sender: Any) {
        
        
    }
    
    @IBAction func showDetailAccountAction(_ sender: Any) {
        performSegue(withIdentifier: "ShowAccountView", sender: userPerson)
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
