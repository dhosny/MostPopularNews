//
//  MostPopularArticalsViewController.swift
//  MostPopularNews
//
//  Created by Dalia Hosny on 5/22/20.
//  Copyright © 2020 Dalia Hosny. All rights reserved.
//

import UIKit
import SVProgressHUD

class MostPopularArticalsViewController: UIViewController {

    var presenter: MostPopularArticalsPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    

}

extension MostPopularArticalsViewController:UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfTableRowsPerSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier:"ArticalTableViewCell", for: indexPath) as! ArticalTableViewCell
        cell.selectionStyle = .none
        presenter?.configureTableCell(cell: cell, forSection: indexPath.section, forRow: indexPath.row)
        return cell
    }
}

extension MostPopularArticalsViewController: MostPopularArticalsView{
    func showProgress() {
        DispatchQueue.main.async(execute: {
            SVProgressHUD.show()
        })
    }
    
    func hideProgress() {
       DispatchQueue.main.async(execute: {
            SVProgressHUD.dismiss()
        })
    }
    
    func displayError(title: String, message: String) {
        DispatchQueue.main.async(execute: {
            
        })
    }
    
    func displayTost(message: String) {
        DispatchQueue.main.async(execute: {
            
        })
    }
    
    func reloadTableData() {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    
}
