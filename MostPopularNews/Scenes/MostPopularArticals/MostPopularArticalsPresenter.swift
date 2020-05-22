//
//  LoginViewPresenter.swift
//  Tadawy
//
//  Created by MAC on 1/16/19.
//  Copyright © 2019 CodexGlobal. All rights reserved.
//

import Foundation

protocol MostPopularArticalsView: class {
    func showProgress()
    func hideProgress()
    func displayError(title: String, message: String)
    func displayTost( message: String)
    func reloadTableData()
}

protocol MostPopularArticalsPresenter {
    func loadData()
    func numberOfTableRowsPerSection(section: Int) -> Int
    func configureTableCell(cell: ArticalTableViewCell, forSection section: Int, forRow row: Int)
}

class MostPopularArticalsPresenterImp: MostPopularArticalsPresenter {
    
    weak var view: MostPopularArticalsView?

    var articalGateway: ArticalsGateway
    var dataList : [Artical] = []

    init(view: MostPopularArticalsView,
         articalGateway: ArticalsGateway = ArticalsGatewayImp()) {
        self.view = view
        self.articalGateway = articalGateway
    }
    
    func loadData(){
        self.view?.showProgress()
        articalGateway.getMostPopularNews() { (responce) in
            self.view?.hideProgress()
            switch responce{
            case .success(let value):
                print(value)
                self.dataList = value
                self.view?.reloadTableData()
                break
            case .failure(let error):
                self.view?.displayError(title: "", message: error.errorDescription!)
                break
            }
        }
    }
    
    //MARK - Table view date
    func numberOfTableRowsPerSection(section: Int) -> Int {
        return dataList.count
    }
    
    
    func configureTableCell(cell: ArticalTableViewCell, forSection section: Int, forRow row: Int) {
        
        cell.display(title: dataList[row].title ?? "")
        cell.display(subtitle: dataList[row].abstract ?? "")
        cell.display(description: dataList[row].byline ?? "")
        cell.display(dateStr: dataList[row].publishedDate ?? "")
        cell.setImg(url: dataList[row].media?[0].mediaMetadata?[0].url ?? "")
       
    }
        
    

    
}
