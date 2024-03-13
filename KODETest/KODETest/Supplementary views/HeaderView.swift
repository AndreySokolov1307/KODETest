//
//  HeaderView.swift
//  KODETest
//
//  Created by Андрей Соколов on 13.03.2024.
//

import UIKit

class HeaderView: UIView {
    
    @UseAutolayout private var leftLine: UIView = .style {
        $0.backgroundColor = Constants.colors.lightGrey
    }
    
    @UseAutolayout private var rightLine: UIView = .style {
        $0.backgroundColor = Constants.colors.lightGrey
    }
    
    @UseAutolayout var titleLabel: UILabel = .style {
        $0.font = Constants.fonts.headerTitle
        $0.textColor = Constants.colors.lightGrey
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Constants.colors.white
        addSubview(leftLine)
        addSubview(titleLabel)
        addSubview(rightLine)
        
        NSLayoutConstraint.activate([
            leftLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.layout.leftLineLeading),
            leftLine.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftLine.widthAnchor.constraint(equalToConstant:  Constants.layout.headerLineWidth),
            leftLine.heightAnchor.constraint(equalToConstant: Constants.layout.headerLineHeight),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.layout.rightLineTrailing),
            rightLine.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightLine.widthAnchor.constraint(equalToConstant: Constants.layout.headerLineWidth),
            rightLine.heightAnchor.constraint(equalToConstant: Constants.layout.headerLineHeight),
        ])
    }
}
