//
//  SortOptionView.swift
//  KODETest
//
//  Created by Андрей Соколов on 15.03.2024.
//

import UIKit

class SortOptionView: UIView {
    
    @UseAutolayout var optionImageView: UIImageView = .style {
        $0.image = Constants.images.sortPlain
    }
    
    @UseAutolayout var optionLabel: UILabel = .style {
        $0.font = Constants.fonts.sortLabel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toSelectedState() {
        optionImageView.image = Constants.images.sortSelected
    }
    
    func toNormalState() {
        optionImageView.image = Constants.images.sortPlain
    }
    
    private func configureView() {
        addSubview(optionImageView)
        addSubview(optionLabel)
        
        NSLayoutConstraint.activate([
            optionImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            optionImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            optionImageView.heightAnchor.constraint(equalToConstant: Constants.layout.sortAlphabetButtonHeight),
            optionImageView.widthAnchor.constraint(equalToConstant: Constants.layout.sortAlphabetButtonWidth),
            
            optionLabel.leadingAnchor.constraint(equalTo: optionImageView.trailingAnchor, constant: 12),
            optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
