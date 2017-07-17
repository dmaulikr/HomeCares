
//
//  HomePageViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import ImageSlideshow

class HomePageViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    
    internal let homeCareService = HomeCaresService()
    internal var blogs = [Blog]()
    

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBlogs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.clearSeparator()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.register(UINib.init(nibName: "OptionMenuCell", bundle: nil), forCellReuseIdentifier: "OptionMenuCell")
        self.tableView.register(UINib.init(nibName: "SlideShowCell", bundle: nil), forCellReuseIdentifier: "SlideShowCell")
    }
    
    internal func getBlogs() {
        self.tableView.startHeaderLoading()
        homeCareService.getBlogs(handler: { [weak self] (response) in
            guard let sSelf = self else {return}
            
            if let hasData = response.data {
                sSelf.blogs = hasData
                sSelf.tableView.reloadData()
            }
            sSelf.tableView.stopHeaderLoading()
        })
    }
    
    internal func showViewController(menu: OptionMenu) {
        switch menu.type! {
        case .call:
            break
            //performSegue(withIdentifier: "ShowCallView", sender: menu)
        case .schedule:
            performSegue(withIdentifier: "ShowScheduleView", sender: menu)
        case .findHospital:
            performSegue(withIdentifier: "ShowFindHospitalView", sender: menu)
        case .findPhamacy:
            performSegue(withIdentifier: "ShowFindPhamacyView", sender: menu)
        case .searchMedical:
            performSegue(withIdentifier: "ShowSearchMedicalView", sender: menu)
        default:
            performSegue(withIdentifier: "ShowSearchDiseaseView", sender: menu)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBlogDetail" {
            if let vc = segue.destination as? BlogDetailViewController {
                vc.blog = sender as? Blog
            }
        }
    }
}

extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0  || indexPath.row == 1 {
            return
        }
        
        performSegue(withIdentifier: "ShowBlogDetail", sender: blogs[indexPath.row - 2])
    }
}

extension HomePageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  blogs.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "SlideShowCell", for: indexPath) as! SlideShowCell
            cell.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, cell.bounds.size.width)
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "OptionMenuCell", for: indexPath) as! OptionMenuCell
            cell.delegate = self
            cell.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, cell.bounds.size.width)
            return cell
        }
        if indexPath.row == 2 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "BlogHeaderCell", for: indexPath) as! BlogHeaderCell
            cell.configure(blog: blogs.first!)
            return cell
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
        cell.configure(blog: blogs[indexPath.row - 2])
        return cell
        
    }
}

extension HomePageViewController: OptionMenuCellDelegate {
    func didSelectMenuItem(menu: OptionMenu) {
        showViewController(menu: menu)
    }
}

extension HomePageViewController: ServiceDetailCellDelegate {
    func didSelectRegisterService(service: ServiceItem) {
        performSegue(withIdentifier: "ShowMedicalBookView", sender: service)
    }
}
