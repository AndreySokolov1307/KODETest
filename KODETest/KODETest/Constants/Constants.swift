//
//  Constants.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import Foundation

enum Constants {
    enum strings {
        static let httpMethodGET: String = "GET"
        static let baseURLString = "https://stoplight.io/mocks/kode-api/trainee-test/331141861"
        static let path = "/users"
        static let headers: [String : String] = [
            "Content-Type": "application/json",
            "Prefer" : "code=200, example=success"
            ]
        
    }
}
