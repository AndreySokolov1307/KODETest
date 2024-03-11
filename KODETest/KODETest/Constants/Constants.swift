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
        static let space = " "
        static let httpMethodGET: String = "GET"
        static let baseURLString = "https://stoplight.io/mocks/kode-api/trainee-test/331141861"
        static let path = "/users"
        static let headers: [String : String] = [
            "Content-Type": "application/json",
            "Prefer" : "code=200, example=success"
            ]
        static let errorHeaders: [String : String] = [
            "Content-Type": "application/json",
            "Prefer" : "code=500, example=error-500"
            ]
        static let all = "Все"
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
        static let tryAgainButton = "Попробовать снова"
        static let errorTitle = "Какой-то сверхразум все сломал"
        static let errorSubtitle = "Постараемся быстро починить"
        static let sortAlphabet = "По алфавиту"
        static let sortBirthday = "По дню рождения"
        static let sortNavBar = "Сортировка"
    }
    
    enum numbers {
        static let loadingTableViewRows = 10
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
        static let tableViewContentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        static let heightForRow: CGFloat = 84
        static let avatarViewCornerRadius: CGFloat = 36
        static let titleViewCornerRadius: CGFloat = 8
        static let subtitleViewCornerRadius: CGFloat = 6
        static let avatarViewTop: CGFloat = 6
        static let avatarViewLeading: CGFloat = 16
        static let avatarViewBottom: CGFloat = -6
        static let avatarViewHeight: CGFloat = 72
        static let avatarViewWidth: CGFloat = 72
        static let titleViewTop: CGFloat = 25
        static let titleViewLeading: CGFloat = 16
        static let titleViewHeight: CGFloat = 16
        static let titleViewWidth: CGFloat = 144
        static let subtitleViewTop: CGFloat = 6
        static let subtitleViewHeight: CGFloat = 12
        static let subtitleViewWidth: CGFloat = 80
        static let gradientStartPoint = CGPoint(x: 0.0, y: 0.5)
        static let gradientEndPoint = CGPoint(x: 1.0, y: 0.5)
        static let avatarImageTop: CGFloat = 6
        static let avatarImageLeading: CGFloat = 16
        static let avatarImageBottom: CGFloat = -6
        static let avatarImageHeight: CGFloat = 72
        static let avatarImageWidth: CGFloat = 72
        static let vStackLeading: CGFloat = 16
        static let birthDateLabelTrailing: CGFloat = -16
        static let errorVStackSpacing: CGFloat = 12
        static let errorVStackCustomSpasing: CGFloat = 8
        static let errorImageWidth: CGFloat = 56
        static let errorImageHeight: CGFloat = 56
        static let sortAlphabetButtonHeight: CGFloat = 24
        static let sortAlphabetButtonWidth: CGFloat = 24
        static let topHStackTop: CGFloat = 8
        static let topHStackLeading: CGFloat = 24
        static let topHstackTrailing: CGFloat = -24
        static let topHstackHeight: CGFloat = 60
    }
    
    enum fonts {
        static let selectedScope = UIFont.systemFont(ofSize: 15, weight: .semibold)
        static let plainScope =  UIFont.systemFont(ofSize: 15, weight: .medium)
        static let searchBar = UIFont.systemFont(ofSize: 15, weight: .medium)
        static let titleLabel = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let subtitleLabel = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let userTagLabel = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let bithDateLabel = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let errorTitle = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let errorSubtitle = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let tryAgainButton = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let sortLabel = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    enum colors {
        static let purple = UIColor(named: "purple")
        static let grey = UIColor(named: "grey")
        static let darkGrey = UIColor(named: "darkGrey")
        static let lightGrey = UIColor(named: "lightGrey")
        static let lightGrey2 = UIColor(named: "lightGrey2")
        static let lightGrey3 = UIColor(named: "lightGrey3")
        static let lightGrey4 = UIColor(named: "lightGrey4")
        static let black2 = UIColor(named: "black2")
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
        static let stub = UIImage(named: "stub")
        static let flyingSaucer = UIImage(named: "flyingSaucer")
        static let back = UIImage(named: "back")
    }
}
