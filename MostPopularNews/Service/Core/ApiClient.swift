//
//  APIClient.swift
//
//  Copyright © 2019 Dalia Hosny. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClient {
    func getRequest(apiURL: String, withParameter parameter: String,  completion: @escaping (_ responce : Result<Any, ServiceError>) -> ())
    //func postRequest(apiURL: String, withParameter parameter: NSDictionary,  completion: @escaping (_ responce : Result<Any, ServiceError>) -> ())
}

class APIClientImp: APIClient {
    
    func getRequest(apiURL: String, withParameter parameter: String = "",   completion: @escaping (_ responce : Result<Any, ServiceError>) -> ()) {
        
        var urlString = "\(Config.sharedInstance.baseUrl!)\(apiURL)"
        if parameter != "" {
            urlString = "\(urlString)?\(parameter)"
        }
        print(urlString)
        
        let escapedAddress = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let headers = ["Content-Type":"application/json", "Accept":"application/json"]

        let method: HTTPMethod = .get
        Alamofire.request(escapedAddress!, method: method, parameters: nil,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
                switch response.result {
                case .success:
                    let statusCode = response.response?.statusCode
                    print(statusCode!)
                    if statusCode == 200 {
                        if let JSON = response.result.value {
                            //print(JSON)
                            completion(.success(JSON))
                        }
                    }else{
                        completion(.failure(ServiceError(json: response.result.value as! [String : Any])))
                    }
                    break
                case.failure(let error):
                    print(error)
                    completion(.failure(.noInternetConnection))
                    break
                }
        }
    }
    
}
