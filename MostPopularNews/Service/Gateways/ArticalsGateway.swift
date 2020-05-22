//
//  HomeGateway.swift
//  Tamm
//
//  Created by Ebrahim Attalla on 3/25/20.
//  Copyright © 2020 Dalia Hosny. All rights reserved.
//

import Foundation


protocol ArticalsGateway {
    
    func getMostPopularNews(completion: @escaping (_ responce: Result<[Artical], ServiceError> ) -> ())
}

class ArticalsGatewayImp: ArticalsGateway {
    
    let MOST_POPULAR_API = "/mostpopular/v2/viewed/1.json"
    
    let apiClient: APIClient
    init(apiClient: APIClient = APIClientImp()) { self.apiClient = apiClient }

    func getMostPopularNews(completion: @escaping (_ responce: Result<[Artical], ServiceError> ) -> ()){
        let apiURL = MOST_POPULAR_API
        apiClient.getRequest(apiURL: apiURL, withParameter: ""){
            (responce) in
            switch responce{
            case .success(let value):
                if let dict = value as? [String: Any]{
                    if let data = dict["data"] as? [[String: Any]]{
                        do{
                            let decoder = JSONDecoder()
                            let jsonData = try? JSONSerialization.data(withJSONObject: data)
                            let dataList = try decoder.decode([City].self, from:jsonData!)
                            completion(.success(dataList))
                        }
                        catch let err{
                            completion(.failure(.custom(err.localizedDescription)))
                        }
                    }
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
