//
//  APIRequest.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol IEndpoint {
    var httpMethod: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [ String : Any ]  { get }
}

class Endpoint: IEndpoint {
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var baseURLString: String {
        return "https://stoplight.io/mocks/kode-api/trainee-test/331141861"
    }
    
    var path: String {
        return "/users"
    }
    
    var headers: [String : Any] {
        return [
        "Content-Type": "application/json",
        "Prefer" : "code=200, example=success"
        ]
    }
}

extension IEndpoint {
    var url: String {
        return baseURLString + path
    }
}

