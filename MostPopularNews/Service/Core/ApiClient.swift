//
//  APIClient.swift
//
//  Created by MAC on 1/21/19.
//  Copyright © 2019 Dalia Hosny. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClient {
    func getRequest(apiURL: String, withParameter parameter: String,  completion: @escaping (_ responce : Result<Any, ServiceError>) -> ())
    func postRequest(apiURL: String, withParameter parameter: NSDictionary,  completion: @escaping (_ responce : Result<Any, ServiceError>) -> ())
}

class APIClientImp: APIClient {
    
    func getRequest(apiURL: String, withParameter parameter: String = "",   completion: @escaping (_ responce : Result<Any, ServiceError>) -> ()) {
        
        var urlString = "\(Config.sharedInstance.baseUrl!)\(apiURL)"
        if parameter != "" {
            urlString = "\(urlString)?\(parameter)"
        }
        print(urlString)
        
        let escapedAddress = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var headers = ["Content-Type":"application/json", "Accept":"application/json"]
        if let token = UserDefaults.standard.object(forKey: "Access_Token") as? String{
            //request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
           headers["Authorization"] = "Bearer \(token)"
        }
        headers["lang"] = "\(L102Language.currentAppleLanguage())"

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
    
    func postRequest(apiURL: String, withParameter parameter: NSDictionary,  completion: @escaping (_ responce : Result<Any, ServiceError>) -> ()) {
        
//        let language = L102Language.currentAppleLanguage()
//       // let lang = "\(language.prefix(2))"
//        var headers = ["lang":"\(language)",
//             "token" : ""]
//        if let token = UserDefaults.standard.object(forKey: "Token") as? String{
//            headers = ["lang":"\(language)",
//                       "token" : token]
//        }
        var headers = ["Content-Type":"application/json", "Accept":"application/json"]
        if let token = UserDefaults.standard.object(forKey: "Access_Token") as? String{
            //request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
           headers["Authorization"] = "Bearer \(token)"
        }
        headers["lang"] = "\(L102Language.currentAppleLanguage())"
        let urlString = NSString(format: "%@%@",Config.sharedInstance.baseUrl!,apiURL)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
        
        let escapedAddress = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let method: HTTPMethod = .post
        
        Alamofire.request(escapedAddress!, method: method, parameters: parameter as? Parameters ,encoding: JSONEncoding.default, headers: headers).validate(contentType: ["application/json"]).responseJSON {
            response in
             switch response.result {
                case .success:
                   let statusCode = response.response?.statusCode
                   print(statusCode!)
                   if statusCode == 200 {
                       if let JSON = response.result.value {
                           print(JSON)
                           completion(.success(JSON))
                       }
                   }else{
                       completion(.failure(ServiceError(json: response.result.value as! [String : Any])))
                   }
                   break
                case.failure(let error):
                   print(error.localizedDescription)
                   completion(.failure(.noInternetConnection))
                   break
                }
        }
    }
    
//    func uploadImage(apiURL: String, withParameter parameter: NSDictionary,  completion: @escaping (_ responce : NSDictionary,_ status : Int) -> ()) {
//
//           let language = L102Language.currentAppleLanguage()
//           // let lang = "\(language.prefix(2))"
//           var headers = ["lang":"\(language)",
//               "token" : ""]
//           if let token = UserDefaults.standard.object(forKey: "Token") as? String{
//               headers = ["lang":"\(language)",
//                   "token" : token]
//           }
//
//           let urlString = NSString(format: "%@%@",Config.sharedInstance.baseUrl!,apiURL)
//
//           //let urlRequest = URLRequest(url: URL(string: urlString as String)!)
//           //let urlString = urlRequest.url?.absoluteString
//           //let escapedAddress = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//
//           let method: HTTPMethod = .post
//
//           let imageData = parameter["data"] as! Data
//           let key = parameter["key"] as! String
//           let filename = parameter["filename"] as! String
//           let mimeType = parameter["mimeType"] as! String
//
//           let url = try! URLRequest(url: URL(string:urlString as String)!, method: method, headers: headers)
//
//           Alamofire.upload(multipartFormData: { (multipartFormData) in
//               multipartFormData.append(imageData, withName: key, fileName: filename, mimeType: mimeType)
//           }, with:url)
//           { (result) in
//               switch result {
//               case .success(let upload, _, _):
//
//                   upload.uploadProgress(closure: { (Progress) in
//                       print("Upload Progress: \(Progress.fractionCompleted)")
//                   })
//
//                   upload.responseJSON { response in
//                       //self.delegate?.showSuccessAlert()
//                       print(response.request)  // original URL request
//                       print(response.response) // URL response
//                       print(response.data)     // server data
//                       print(response.result)   // result of response serialization
//                       //                        self.showSuccesAlert()
//                       //self.removeImage("frame", fileExtension: "txt")
//                       if let JSON = response.result.value {
//                           print("JSON: \(JSON)")
//                           let responce = JSON as! NSDictionary
//                           print(responce)
//                           let status =  responce.object(forKey: "success") as! NSNumber
//                           if  status == 1
//                           {
//                               let result = responce.object(forKey: "data")
//                               if result is NSDictionary {
//                                   completion( result as! NSDictionary,1)
//                               }else if result is String{
//                                   completion( ["message": result!] as NSDictionary,1)
//                               }
//
//                           }
//                           else  if  status == -1
//                           {
//                               completion(["message":NSLocalizedString("Unathorized Access", comment: "") ], -1 )
//
//                           }else{
//                               completion(["message":self.extractErrorMsg(responce: responce)],0)
//                           }
//                       }
//                   }
//
//               case .failure(let encodingError):
//                   //self.delegate?.showFailAlert()
//                   print(encodingError)
//                   completion(["message":NSLocalizedString("Problem in server side please wait and try again later.", comment: "") ], 0 )
//               }
//
//           }
//       }
//
}
