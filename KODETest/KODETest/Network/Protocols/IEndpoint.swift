//
//  IEndpoint.swift
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
    var headers: [ String : String ]  { get }
}

extension IEndpoint {
    var url: String {
        return baseURLString + path
    }
}

