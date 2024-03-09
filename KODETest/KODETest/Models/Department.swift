//
//  Department.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import Foundation

enum Department: String, Codable {
    case android, ios, design, management, qa,
         backOffice = "back_office",
         frontend, hr, pr, backend, support, analytics
    
    var title: String {
        switch self {
        case .android:
            return Constants.strings.android
        case .ios:
            return Constants.strings.ios
        case .design:
            return Constants.strings.design
        case .management:
            return Constants.strings.management
        case .qa:
            return Constants.strings.qa
        case .backOffice:
            return Constants.strings.backOffice
        case .frontend:
            return Constants.strings.frontend
        case .hr:
            return Constants.strings.hr
        case .pr:
            return Constants.strings.pr
        case .backend:
            return Constants.strings.backend
        case .support:
            return Constants.strings.support
        case .analytics:
            return Constants.strings.analytics
        }
    }
}
