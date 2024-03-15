//
//  FilterManager.swift
//  KODETest
//
//  Created by Андрей Соколов on 15.03.2024.
//

import Foundation

final class FilterManager {
    func isIncluded(_ user: User, searchTerm: String, department: String) -> Bool {
        if !searchTerm.isEmpty {
            if department == Department.all.title {
                return user.fullName.localizedCaseInsensitiveContains(searchTerm) || user.userTag.localizedCaseInsensitiveContains(searchTerm)
            } else {
                return (user.fullName.localizedCaseInsensitiveContains(searchTerm) || user.userTag.localizedCaseInsensitiveContains(searchTerm)) && user.department.title == department
            }
        } else {
            if department == Department.all.title {
                return true
            } else {
                return user.department.title == department
            }
        }
    }
    
    func filter(_ users: [User], withSearchTerm searchTerm: String, department: String) -> [User] {
        var filteredUsers = [User]()
            filteredUsers = users.filter({ user in
                return isIncluded(user, searchTerm: searchTerm, department: department)
            })
        return filteredUsers
    }
}
