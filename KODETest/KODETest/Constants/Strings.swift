//
//  Strings.swift
//  KODETest
//
//  Created by Андрей Соколов on 11.03.2024.
//

import Foundation

extension Constants {
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
        static let searchBarPlaceholder = "Введите имя, тег, почту..."
        static let tryAgainButton = "Попробовать снова"
        static let errorTitle = "Какой-то сверхразум все сломал"
        static let errorSubtitle = "Постараемся быстро починить"
        static let sortAlphabet = "По алфавиту"
        static let sortBirthday = "По дню рождения"
        static let sortNavBar = "Сортировка"
        static let emptySearchTitle = "Мы никого не нашли"
        static let emptySearchSubtitle = "Попробуй скорректировать запрос"
        static let shortDateFormat = "MMM d"
        static let regularDateFromat = "yyyy-MM-dd"
        static let loadingCellReuseIdentifier = "LoadingCell"
        static let userCellReuseIdentifier = "UserCell"
        
    }
}
