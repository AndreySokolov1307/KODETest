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
    let department: Department
    let position: String
    let birthday: String
    let phone: String
    
    var fullName: String {
        firstName + Constants.strings.space + lastName
    }
    
    var birthdayDate: Date? {
        let dateFoormatter = DateFormatter()
        dateFoormatter.dateFormat = Constants.strings.regularDateFromat
        dateFoormatter.timeZone = .current
        return dateFoormatter.date(from: birthday)
    }
    
    var birthdayDateForSort: Date? {
      guard let date = birthdayDate else { return nil }
      let string = ShortDateFomatter().string(from: date)
      return   ShortDateFomatter().date(from: string)
    }
}

