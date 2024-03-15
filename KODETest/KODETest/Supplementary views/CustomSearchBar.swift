//
//  CustomSearchBar.swift
//  KODETest
//
//  Created by Андрей Соколов on 10.03.2024.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        //TODO: - Download INTER font
        
        searchTextField.layer.cornerRadius = Constants.layout.seatchTextFieldCornerRadius
        searchTextField.layer.masksToBounds = true
        searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.strings.searchBarPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : Constants.colors.lightGrey])
        setValue("Отмена", forKey: "cancelButtonText")
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.font : Constants.fonts.searchBarCancel], for: .normal
        )
        searchTextField.font = Constants.fonts.searchBar
        tintColor = Constants.colors.purple
        searchTextField.backgroundColor = Constants.colors.lightGrey2
        showsBookmarkButton = true
        setImage(Constants.images.listPlain, for: .bookmark, state: .normal)
        setImage(Constants.images.searchPlain, for: .search, state: .normal)
        setImage(Constants.images.clear, for: .clear, state: .normal)
        
        setPositionAdjustment(Constants.layout.searchPositionOffset, for: .search)
        setPositionAdjustment(Constants.layout.bookmarkPositionOffset, for: .bookmark)
        setPositionAdjustment(Constants.layout.clearPositionOffset, for: .clear)
    }
}
