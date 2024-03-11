//
//  SortButton.swift
//  KODETest
//
//  Created by Андрей Соколов on 11.03.2024.
//

import UIKit

class SortButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        setImage(Constants.images.sortPlain , for: .normal)
        setImage(Constants.images.sortSelected, for: .selected)
    }
}
