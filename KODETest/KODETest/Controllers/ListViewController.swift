//
//  ListViewController.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit

class ListViewController: UIViewController {
    private enum Section {
        case all, thisYear, nextYear
        
        static func getSections(_ sortType: SortType) -> [Section] {
            if sortType == .alphabet {
                return [.all]
            } else {
                return [.thisYear, .nextYear]
            }
        }
    }
    private enum FetchResult {
        case success
        case failure
    }
    
    private lazy var listView = ListView()
    private lazy var networkService = NetworkService()
    private let searchBar = CustomSearchBar()
    private var sortType: SortType = .alphabet
    private var isLoading = true
    private var searchTask: Task<Void, Never>? = nil
    private var sections: [Section] {
        Section.getSections(sortType)
    }
    private var users = [User]() {
        didSet {
            isLoading = false
            listView.refreshControl.endRefreshing()
        }
    }

    private var usersThisYear = [User]()
    private var usersNextYear = [User]()
    
    private var usersFilteredSortedThisYear = [User]()
    private var usersFilteredSortedNextYear = [User]()
    private var sortedUsers = [User]()
    private var filteredSortedUsers = [User]()
 
    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupScopeBar()
        setupTableView()
        setupErrorView()
        
        getUsers()
    }
    
    private func getUsers() {
        searchTask = Task {
            do {
                users = try await networkService.fetchUsers()
                getUsersSorted()
                updateUI(with: .success)
                updateSearchResult(with: searchBar.text, department: listView.scopeBar.selectedDepartment)
            } catch {
                updateUI(with: .failure)
            }
        }
    }
    private func updateUI(with result: FetchResult) {
        listView.tableView.backgroundView?.isHidden = true
        navigationItem.titleView?.isHidden = result == .success ? false : true
        listView.errorView.isHidden =  result == .success ? true : false
    }
    
    private func setupTableView() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.reuseIdentifier)
        listView.tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        listView.refreshControl.addTarget(self, action: #selector(didPullRefreshControl(sender:)), for: .valueChanged)
    }
    
    private func setupScopeBar() {
        listView.scopeBar.scopeButtons.forEach { button in
            button.sizeToFit()
            button.widthConstraint = button.widthAnchor.constraint(equalToConstant: button.frame.width)
            button.widthConstraint?.isActive = true
            button.addTarget(self, action: #selector(didTapScopeButton(sender:)), for: .touchUpInside)
        }
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setupErrorView() {
        listView.errorView.tryAgainButton.addTarget(self, action: #selector(didTapTryAgainButton), for: .touchUpInside)
    }
    
    private func getUsersSorted() {
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
    
    private func filterUser(_ user: User, searchTerm: String) -> Bool {
        if !searchTerm.isEmpty {
            return user.fullName.localizedCaseInsensitiveContains(searchTerm) || user.userTag.localizedCaseInsensitiveContains(searchTerm)
        } else {
            return true
        }
    }
    
    private func updateSearchResult(with searchTerm: String?, department: String) {
        guard let searchTerm = searchTerm else { return }
            if sortType == .alphabet {
                if department != Department.all.title {
                    filteredSortedUsers = sortedUsers.filter({ user in
                       return filterUser(user, searchTerm: searchTerm) && user.department.title == department
                    })
                } else {
                    filteredSortedUsers = sortedUsers.filter({ user in
                        return filterUser(user, searchTerm: searchTerm)
                    })
                }
                listView.tableView.backgroundView?.isHidden = filteredSortedUsers.isEmpty ? false : true
            } else {
                if department != Department.all.title {
                    usersFilteredSortedThisYear =  usersThisYear.filter { user in
                        return filterUser(user, searchTerm: searchTerm) && user.department.title == department
                    }
                    usersFilteredSortedNextYear =  usersNextYear.filter { user in
                        return filterUser(user, searchTerm: searchTerm) && user.department.title == department
                    }
                } else {
                    usersFilteredSortedThisYear =  usersThisYear.filter { user in
                        return filterUser(user, searchTerm: searchTerm)
                    }
                    usersFilteredSortedNextYear =  usersNextYear.filter { user in
                        return filterUser(user, searchTerm: searchTerm)
                    }
                }
                listView.tableView.backgroundView?.isHidden = usersFilteredSortedThisYear.isEmpty && usersFilteredSortedNextYear.isEmpty ? false : true
            }
        listView.tableView.reloadData()
    }
    
    @objc func didTapTryAgainButton() {
        listView.errorView.isHidden = true
        navigationItem.titleView?.isHidden = false
        networkService.endpoint.headers = Constants.strings.headers
        getUsers()
    }
    
    @objc func didTapScopeButton(sender: ScopeButton) {
        listView.scopeBar.selectedButton = sender
        if let text = searchBar.text {
            print(text, listView.scopeBar.selectedDepartment)
            updateSearchResult(with: text, department: listView.scopeBar.selectedDepartment)
        }
    }
    
    @objc func didPullRefreshControl(sender: UIRefreshControl) {
        getUsers()
    }
}

//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    private func numberOfRows(for section: Section, isLoading: Bool) -> Int {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows(for: sections[section], isLoading: isLoading)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier) as! LoadingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier) as! UserCell
            let user: User
            switch sections[indexPath.section] {
            case .all:
                 user = filteredSortedUsers[indexPath.row]
            case .thisYear:
                 user = usersFilteredSortedThisYear[indexPath.row]
            case .nextYear:
                 user = usersFilteredSortedNextYear[indexPath.row]
            }
            Task {
                await cell.configure(for: user, with: networkService)
            }
            cell.birthDateLabel.isHidden = sortType == .alphabet ? true : false
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.layout.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user: User
        switch sections[indexPath.section] {
        case .all:
            user = filteredSortedUsers[indexPath.row]
        case .thisYear:
            user = usersFilteredSortedThisYear[indexPath.row]
        case .nextYear:
            user = usersFilteredSortedNextYear[indexPath.row]
        }
        navigationController?.pushViewController(DetailUserViewController(user: user, networkService: networkService), animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !usersFilteredSortedNextYear.isEmpty else { return nil }
        if sections[section] == .nextYear {
            let header = HeaderView()
            header.titleLabel.text = Constants.functions.getNextYearString()
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard !usersFilteredSortedNextYear.isEmpty else { return Constants.layout.sectionHeaderHeight }
        if sections[section] == .nextYear {
            return Constants.layout.nextYearSectionHeaderHeight
        } else {
            return Constants.layout.sectionHeaderHeight
        }
    }
}

//MARK: - UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResult(with: searchText, department: listView.scopeBar.selectedDepartment)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.setImage(Constants.images.searchSelected, for: .search, state: .normal)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        if let text = searchBar.text,
           text.isEmpty {
            searchBar.setImage(Constants.images.searchPlain, for: .search, state: .normal)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = Constants.strings.emptyString
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        showSortVCAsSheet()
    }
    
    private func showSortVCAsSheet() {
        let vc = SortViewController(sortType: sortType)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = Constants.layout.sheetCornerRadius
        }
        present(nav, animated: true)
    }
}

//MARK: - SortViewControllerDelegate

extension ListViewController: SortViewControllerDelegate {
    func didChooseSortType(_ sortType: SortType) {
        isLoading = true
        self.sortType = sortType
        switch sortType {
        case .alphabet:
            searchBar.setImage(Constants.images.listPlain, for: .bookmark, state: .normal)
        case .birthday:
            searchBar.setImage(Constants.images.listSelected, for: .bookmark, state: .normal)
        }
        listView.tableView.reloadData()
        getUsers()
    }
}
