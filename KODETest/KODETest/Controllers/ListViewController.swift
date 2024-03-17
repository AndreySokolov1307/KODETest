//
//  ListViewController.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit

final class ListViewController: UIViewController {
    private enum FetchResult {
        case success
        case failure
    }
    
    private lazy var listView = ListView()
    private lazy var networkService = NetworkService()
    private let searchBar = CustomSearchBar()
    private var sortType: SortType = .alphabet
    private lazy var dataSourceManager = DataSourceManager(sortType: sortType)
    private var filterManager = FilterManager()
    private var isLoading = true
    private var searchTask: Task<Void, Never>? = nil
    private var shouldIgnoreError = false
    
 
    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupScopeBar()
        setupTableView()
        setupErrorView()
        setupDataSource()
        
        getUsers()
    }
    private func setupDataSource() {
        dataSourceManager.didSet = { [weak self] in
            self?.isLoading = false
            self?.listView.refreshControl.endRefreshing()
        }
    }
    
    private func getUsers() {
        searchTask = Task {
            do {
                dataSourceManager.users = try await networkService.fetchUsers()
                dataSourceManager.getUsersSorted()
                updateUI(with: .success)
                updateSearchResult(with: searchBar.text, department: listView.scopeBar.selectedDepartment)
            } catch {
                if !shouldIgnoreError {
                    updateUI(with: .failure)
                } else {
                    listView.refreshControl.endRefreshing()
                }
            }
            shouldIgnoreError = false
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
    
    private func updateSearchResult(with searchTerm: String?, department: String) {
        guard let searchTerm = searchTerm else { return }
        if sortType == .alphabet {
            dataSourceManager.filteredSortedUsers = filterManager.filter(dataSourceManager.sortedUsers,
                                                                         withSearchTerm: searchTerm,
                                                                         department: department)
                                                                         
            listView.tableView.backgroundView?.isHidden = dataSourceManager.filteredSortedUsers.isEmpty ? false : true
            listView.tableView.reloadSections(dataSourceManager.sectionIndexSet, with: .none)
        } else {
            dataSourceManager.usersFilteredSortedThisYear = filterManager.filter(dataSourceManager.usersThisYear,
                                                                                 withSearchTerm: searchTerm,
                                                                                 department: department)
                                                                                
            dataSourceManager.usersFilteredSortedNextYear = filterManager.filter(dataSourceManager.usersNextYear,
                                                                                 withSearchTerm: searchTerm,
                                                                                 department: department)
                                                                                 
            listView.tableView.backgroundView?.isHidden = dataSourceManager.usersFilteredSortedThisYear.isEmpty && dataSourceManager.usersFilteredSortedNextYear.isEmpty ? false : true
            listView.tableView.reloadSections(dataSourceManager.sectionIndexSet, with: .fade)
        }        
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
            updateSearchResult(with: text, department: listView.scopeBar.selectedDepartment)
        }
    }
    
    @objc func didPullRefreshControl(sender: UIRefreshControl) {
        shouldIgnoreError = true
        networkService.endpoint.headers = Constants.strings.errorHeaders
        getUsers()
    }
}

//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSourceManager.sections.count
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourceManager.numberOfRows(for: dataSourceManager.sections[section], isLoading: isLoading)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier) as! LoadingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier) as! UserCell
            let user: User
            switch dataSourceManager.sections[indexPath.section] {
            case .all:
                user = dataSourceManager.filteredSortedUsers[indexPath.row]
            case .thisYear:
                user = dataSourceManager.usersFilteredSortedThisYear[indexPath.row]
            case .nextYear:
                user = dataSourceManager.usersFilteredSortedNextYear[indexPath.row]
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
        switch dataSourceManager.sections[indexPath.section] {
        case .all:
            user = dataSourceManager.filteredSortedUsers[indexPath.row]
        case .thisYear:
            user = dataSourceManager.usersFilteredSortedThisYear[indexPath.row]
        case .nextYear:
            user = dataSourceManager.usersFilteredSortedNextYear[indexPath.row]
        }
        searchBar.resignFirstResponder()
        navigationController?.pushViewController(DetailUserViewController(user: user, networkService: networkService), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !dataSourceManager.usersFilteredSortedNextYear.isEmpty else { return nil }
        if dataSourceManager.sections[section] == .nextYear {
            let header = HeaderView()
            header.titleLabel.text = Constants.functions.getNextYearString()
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard !dataSourceManager.usersFilteredSortedNextYear.isEmpty else { return Constants.layout.sectionHeaderHeight }
        if dataSourceManager.sections[section] == .nextYear {
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
        dataSourceManager.sortType = sortType
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
