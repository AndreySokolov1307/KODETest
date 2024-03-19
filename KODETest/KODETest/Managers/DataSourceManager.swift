import Foundation

extension DataSourceManager {
    enum Section {
        case all, thisYear, nextYear
        
        static func getSections(_ sortType: SortType, isLoading: Bool ) -> [Section] {
            if sortType == .alphabet || isLoading {
                return [.all]
            } else {
                return [.thisYear, .nextYear]
            }
        }
    }
   
    func numberOfRows(for section: Section) -> Int {
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

final class DataSourceManager {
    var sortType: SortType
    var didSet: (() -> Void)?
    var users = [User]() {
        didSet {
            didSet?()
            isLoading = false
        }
    }
    var isLoading: Bool = true
    var usersThisYear = [User]()
    var usersNextYear = [User]()
    var sortedUsers = [User]()
    
    var usersFilteredSortedThisYear = [User]()
    var usersFilteredSortedNextYear = [User]()
    var filteredSortedUsers = [User]()
    
    var sections: [Section] {
        Section.getSections(sortType, isLoading: isLoading)
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

