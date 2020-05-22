//
//  MostPopularNewsTests.swift
//  MostPopularNewsTests
//
//  Created by Dalia Hosny on 5/22/20.
//  Copyright © 2020 Dalia Hosny. All rights reserved.
//

import XCTest
@testable import MostPopularNews

class MostPopularNewsTests: XCTestCase {

    var presenter: MostPopularArticalsPresenter!
    var gateway: ArticalGatewayMoke!
    var view: MostPopularViewMoke!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gateway = ArticalGatewayMoke()
        view = MostPopularViewMoke()
        presenter = MostPopularArticalsPresenterImp(view: view as MostPopularArticalsView, articalGateway: gateway as ArticalsGateway)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataCount() {
       XCTAssert(presenter.numberOfTableRowsPerSection(section: 0) == 0)
       presenter.loadData()
       XCTAssert(presenter.numberOfTableRowsPerSection(section: 0) == 3)
    }
    
    func testLoadedData() {
        gateway.responceStates = true
        presenter.loadData()
        XCTAssert(presenter.getDataAt(section: 0, forRow: 0).id == 1)
        XCTAssert(presenter.getDataAt(section: 0, forRow: 0).title == "title1")
        XCTAssert(presenter.getDataAt(section: 0, forRow: 1).id == 2)
        XCTAssert(presenter.getDataAt(section: 0, forRow: 1).title == "title2")
        XCTAssert(presenter.getDataAt(section: 0, forRow: 2).id == 3)
        XCTAssert(presenter.getDataAt(section: 0, forRow: 2).title == "title3")
       
    }
        
    func testFailLoadedData() {
       gateway.responceStates = false
       presenter.loadData()
        XCTAssert(view.error)
      
    }
}

class ArticalGatewayMoke: ArticalsGateway{
    var responceStates: Bool = true
    func getMostPopularNews(completion: @escaping (Result<[Artical], ServiceError>) -> ()) {
        if responceStates {
            var dataList = [Artical]()
            dataList.append(Artical(id: 1, title: "title1"))
            dataList.append(Artical(id: 2, title: "title2"))
            dataList.append(Artical(id: 3, title: "title3"))
            completion(.success(dataList))
        }else{
            completion(.failure(.other))
        }
    }
    
}

class MostPopularViewMoke: MostPopularArticalsView {
    var error: Bool = false
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
    
    func displayError(title: String, message: String) {
        error = true
    }
    
    func displayTost(message: String) {
        
    }
    
    func reloadTableData() {
        
    }
    
    
}
