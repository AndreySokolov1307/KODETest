//
//  User.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import Foundation

struct UserResponce: Codable {
    var items: [User]
}

struct User: Codable {
    let id: String
    let avatarUrl: String
    let firstName: String
    let lastName: String
    let userTag: String
    let department: String
    let position: String
    let birthday: String
    let phone: String
}
