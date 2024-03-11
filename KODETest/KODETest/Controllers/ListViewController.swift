//
//  ListViewController.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit

class ListViewController: UIViewController {
    private enum FetchResult {
        case success
        case failure
    }
    
    private lazy var listView = ListView()
    private lazy var networkService = NetworkService()
    private let searchBar = CustomSearchBar()
    private var sortType: SortType = .alphabet
    private var users = [User]() {
        didSet {
            isLoading = false
            listView.refreshControl.endRefreshing()
        }
    }
    
    private var filteredUsers: [User] {
        var users = users.sorted { $0.fullName < $1.fullName }
        if listView.scopeBar.selectedDepartment != Department.all.title {
            users = users.filter({ user in
                user.department.title == listView.scopeBar.selectedDepartment
            })
        }
        users = users.filter(filterUser(_:))
        return users
    }
    private var isLoading = true
    var searchTask: Task<Void, Never>? = nil
    
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
    
    private func filterUser(_ user: User) -> Bool {
        if let text = searchBar.text,
           !text.isEmpty {
           return user.fullName.localizedCaseInsensitiveContains(text) || user.userTag.localizedCaseInsensitiveContains(text) || user.userTag.localizedCaseInsensitiveContains(text)
        } else {
            return true
        }
    }
    
    private func getUsers() {
        searchTask = Task {
            do {
                users = try await networkService.fetchUsers()
                updateUI(with: .success)
                listView.tableView.reloadData()
            } catch {
                updateUI(with: .failure)
            }
        }
    }
    private func updateUI(with result: FetchResult) {
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
    
    @objc func didTapTryAgainButton() {
        listView.errorView.isHidden = true
        navigationItem.titleView?.isHidden = false
        networkService.endpoint.headers = Constants.strings.headers
        getUsers()
    }
    
    @objc func didTapScopeButton(sender: ScopeButton) {
        listView.scopeBar.selectedButton = sender
        listView.tableView.reloadData()
    }
    
    @objc func didPullRefreshControl(sender: UIRefreshControl) {
        getUsers()
    }
}

//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return Constants.numbers.loadingTableViewRows
        } else {
            return filteredUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier) as! LoadingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier) as! UserCell
            let user = filteredUsers[indexPath.row]
            Task {
                await cell.configure(for: user, with: networkService)
            }
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
       
    }
}


//MARK: - UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listView.tableView.reloadData()
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
        let vc = SortViewController(sortType: sortType)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
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
