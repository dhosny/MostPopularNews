//
//  ArticalsGateway.swift
//
//  Created by Dalia Hosny on 3/25/20.
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
        let param = "api-key=\(Config.sharedInstance.apiKey ?? "")"
        apiClient.getRequest(apiURL: apiURL, withParameter: param){
            (responce) in
            switch responce{
            case .success(let value):
                if let dict = value as? [String: Any]{
                    do{
                        let decoder = JSONDecoder()
                        let jsonData = try? JSONSerialization.data(withJSONObject: dict)
                        let responseData = try decoder.decode(ResponceData.self, from:jsonData!)
                        completion(.success(responseData.results ?? []))
                    }
                    catch let err{
                        completion(.failure(.custom(err.localizedDescription)))
                    }
                }else{
                    completion(.failure(.other))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
