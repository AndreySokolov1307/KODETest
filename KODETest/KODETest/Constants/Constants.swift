//
//  Constants.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit

enum Constants {
    enum strings {
        static let emptyString = ""
        static let httpMethodGET: String = "GET"
        static let baseURLString = "https://stoplight.io/mocks/kode-api/trainee-test/331141861"
        static let path = "/users"
        static let headers: [String : String] = [
            "Content-Type": "application/json",
            "Prefer" : "code=200, example=success"
            ]
        static let android = "Android"
        static let ios = "IOS"
        static let design = "Дизайн"
        static let management = "Менеджмент"
        static let qa = "QA"
        static let backOffice = "Бек-офис"
        static let frontend = "Frontend"
        static let hr = "HR"
        static let pr = "PR"
        static let backend = "Backend"
        static let support = "Техподдержка"
        static let analytics = "Аналитика"
        static let departmentCellReuseIdentifier = "DepartmentCell"
        static let searchBarPlaceholder = "Введите имя, тег, почту..."
    }
    
    enum layout {
        static let scopeBarTop: CGFloat = 8
        static let scopeBarHeight: CGFloat = 37
        static let lineViewHeihgt: CGFloat = 0.2
        static let tableViewTop: CGFloat = 16
        static let departmentCellTitleLableTop: CGFloat = 8
        static let departmentCellTitleLableLeading: CGFloat = 12
        static let departmentCellTitleLableTrailing: CGFloat = -12
        static let departmentCellTitleLableBottom: CGFloat = -8
        static let departmentCellLineViewHeight: CGFloat = 2
        static let scopeButtonContentInsets = UIEdgeInsets(top: 8, left: 12, bottom: 10, right: 12)
        static let scopeBarContentInsetLeft: CGFloat = 16
        static let seatchTextFieldCornerRadius: CGFloat = 16
        static let searchPositionOffset = UIOffset(horizontal: 6, vertical: 0)
        static let bookmarkPositionOffset = UIOffset(horizontal: -6, vertical: 0)
        static let clearPositionOffset = UIOffset(horizontal: -6, vertical: 0)
    }
    
    enum fonts {
        static let selectedScope = UIFont.systemFont(ofSize: 15, weight: .semibold)
        static let plainScope =  UIFont.systemFont(ofSize: 15, weight: .medium)
        static let searchBar = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    enum colors {
        static let purple = UIColor(named: "purple")
        static let grey = UIColor(named: "grey")
        static let lightGrey = UIColor(named: "lightGrey")
        static let lightGrey2 = UIColor(named: "lightGrey2")
        static let white: UIColor = .white
        static let black: UIColor = .black
    }
    
    enum images {
        static let listPlain = UIImage(named: "listPlain")
        static let listSelected = UIImage(named: "listSelected")
        static let searchPlain = UIImage(named: "searchPlain")
        static let searchSelected = UIImage(named: "searchSelected")
        static let sortSelected = UIImage(named: "sortSelected")
        static let sortPlain = UIImage(named: "sortPlain")
        static let clear = UIImage(named: "clear")
    }
}
