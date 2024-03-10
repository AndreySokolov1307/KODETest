//
//  ListViewController.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit

class ListViewController: UIViewController {
    
    lazy var listView = ListView()
    
    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupScopeBar()
    }
    
    private func setupScopeBar() {
        listView.scopeBar.scopeButtons.forEach { button in
            button.sizeToFit()
            print(button.frame.width)
            button.widthConstraint = button.widthAnchor.constraint(equalToConstant: button.frame.width)
            button.widthConstraint?.isActive = true
            button.addTarget(self, action: #selector(didTapScopeButton(sender:)), for: .touchUpInside)
        }
    }
    
    private func setupSearchBar() {
        let searchBar = CustomSearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    @objc func didTapScopeButton(sender: ScopeButton) {
        listView.scopeBar.selectedButton = sender
        print(sender.titleLabel!.text)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        if let text = searchBar.text,
           text.isEmpty {
            searchBar.setImage(Constants.images.searchPlain, for: .search, state: .normal)
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.setImage(Constants.images.searchSelected, for: .search, state: .normal)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = Constants.strings.emptyString
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
