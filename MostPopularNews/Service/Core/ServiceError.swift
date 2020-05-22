//
//  ServiceError.swift
//  Tamm
//
//  Created by Dalia Hosny on 3/21/20.
//  Copyright © 2020 Dalia Hosny. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case noInternetConnection
    //case login_verifyEmailFirst
    case custom(String)
    case other
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet connection"
        case .other:
            return "Something went wrong"
        case .custom(let message):
            return message
//        case .login_verifyEmailFirst:
//            return "verify Account first"
        }
    }
}

extension ServiceError {
    /*
     {
         "message": "The given data was invalid.",
         "errors": {
             "email": [
                 "The email has already been taken."
             ],
             "user_name": [
                 "The user name has already been taken."
             ],
             "phone.number": [
                 "The phone.number has already been taken."
             ]
         }
     }
     */
    init(json: [String: Any]) {
        var messages: [String] = []
        if let errors =  json["errors"] as? [String: Any] {
            for (_, value) in errors {
                if let errorData =  value as? [String] {
                    messages.append(contentsOf: errorData)
                }
            }
        }
            
        if messages.count > 0{
            self = .custom(messages.joined(separator: "\n "))
        } else {
            self = .other
        }
    }
}
