//
//  SettingViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/16/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let window = UIApplication.shared.keyWindow else { return }
        UserDefaults.userId = nil
        UserDefaults.personId = nil
        UserDefaults.avatar = nil
        UserDefaults.email = nil
        UserDefaults.nameUser = nil
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            window.rootViewController = HomeCareNavigationController(rootViewController: vc)
            
        }
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationItemCell", for: indexPath) as?  ApplicationItemCell {
            let option = OptionMenu()
            option.name = "Logout"
            option.image = "ic_invite".image
            cell.configure(option: option)
            return cell
        }
        return UITableViewCell()
    }
}
