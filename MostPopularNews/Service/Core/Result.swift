//
//  Result.swift
//  RESTClient
//
//  Created by Alexandr Gaidukov on 20/10/2017.
//  Copyright © 2017 Alexander Gaidukov. All rights reserved.
//

import Foundation

public enum Result<A, ServiceError> {
    case success(A)
    case failure(ServiceError)
}

extension Result {
    init(value: A?, or error: ServiceError) {
        guard let value = value else {
            self = .failure(error)
            return
        }
        
        self = .success(value)
    }
    
    var value: A? {
        guard case let .success(value) = self else { return nil }
        return value
    }
    
    var error: ServiceError? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}
