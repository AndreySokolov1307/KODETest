//
//  DataSourceManager.swift
//  KODETest
//
//  Created by Андрей Соколов on 15.03.2024.
//

import Foundation

extension DataSourceManager {
    enum Section {
        case all, thisYear, nextYear
        
        static func getSections(_ sortType: SortType ) -> [Section] {
            if sortType == .alphabet {
                return [.all]
            } else {
                return [.thisYear, .nextYear]
            }
        }
    }
   
    func numberOfRows(for section: Section, isLoading: Bool) -> Int {
        switch section {
        case .all:
            if isLoading {
                return Constants.numbers.loadingTableViewRows
            } else {
                return filteredSortedUsers.count
            }
        case .thisYear:
            return usersFilteredSortedThisYear.count
        case .nextYear:
            return usersFilteredSortedNextYear.count
        }
    }
}

class DataSourceManager {
    var sortType: SortType
    var didSet: (() -> Void)?
    var users = [User]() {
        didSet {
            didSet?()
        }
    }
    var usersThisYear = [User]()
    var usersNextYear = [User]()
    var sortedUsers = [User]()
    
    var usersFilteredSortedThisYear = [User]()
    var usersFilteredSortedNextYear = [User]()
    var filteredSortedUsers = [User]()
    
    var sections: [Section] {
        Section.getSections(sortType)
    }
    
    var sectionIndexSet: IndexSet {
        sections.contains(.all) ? Constants.numbers.allSectionIndexSet : Constants.numbers.thisYearNextYearSectionsIndexSet
    }
    
    init(sortType: SortType) {
        self.sortType = sortType
    }
    
    func getUsersSorted() {
        if sortType == .alphabet {
            sortedUsers = []
            sortedUsers = users.sorted { $0.fullName < $1.fullName }
            filteredSortedUsers = sortedUsers
        } else {
            usersNextYear = []
            usersThisYear = []
            let sortedByDayUsers = users.sorted {  $0.birthdayDateForSort! < $1.birthdayDateForSort! }
            for user in sortedByDayUsers {
                if Date.MonthDay(date: user.birthdayDateForSort!) > Date.MonthDay(date: Date()) {
                    usersThisYear.append(user)
                } else {
                    usersNextYear.append(user)
                }
            }
            usersFilteredSortedThisYear = usersThisYear
            usersFilteredSortedNextYear = usersNextYear
        }
    }
}

