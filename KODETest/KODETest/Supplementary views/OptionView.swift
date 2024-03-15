//
//  SortOptionView.swift
//  KODETest
//
//  Created by Андрей Соколов on 15.03.2024.
//

import UIKit

class OptionView: UIView {
    
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
            optionImageView.heightAnchor.constraint(equalToConstant: Constants.layout.optionImageHeight),
            optionImageView.widthAnchor.constraint(equalToConstant: Constants.layout.optionViewHeight),
            
            optionLabel.leadingAnchor.constraint(equalTo: optionImageView.trailingAnchor, constant: Constants.layout.optionLabelLeading),
            optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
