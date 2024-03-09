//
//  Endpoint.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import Foundation

class Endpoint: IEndpoint {
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var baseURLString: String {
        return Constants.strings.baseURLString
    }
    
    var path: String {
        return Constants.strings.path
    }
    
    var headers: [String : String] {
        return Constants.strings.headers
    }
}

