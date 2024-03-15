//
//  Endpoint.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import Foundation

class Endpoint: IEndpoint {
    var httpMethod: HTTPMethod  = .get
    
    var baseURLString: String = Constants.strings.baseURLString
    
    var path: String = Constants.strings.path
    
    //Выбери ответ с сервера
    //var headers: [String : String] = Constants.strings.headers
    var headers: [String : String] = Constants.strings.errorHeaders
}


