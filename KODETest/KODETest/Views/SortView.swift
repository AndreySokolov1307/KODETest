//
//  SortView.swift
//  KODETest
//
//  Created by Андрей Соколов on 11.03.2024.
//

import UIKit

class SortView: UIView {
    
    @UseAutolayout var sortAlphabetButton = SortButton()
    @UseAutolayout var sortBirthdayButton = SortButton()
    
    var sortAplphabelLabel: UILabel = .style {
        $0.text = Constants.strings.sortAlphabet
        $0.font = Constants.fonts.sortLabel
    }
    
    var sortBirthdayLabel: UILabel = .style {
        $0.text = Constants.strings.sortBirthday
        $0.font = Constants.fonts.sortLabel
    }
    
    @UseAutolayout var topHStack: UIStackView = .style {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fill
        $0.alignment = .center
    }
    
    @UseAutolayout var bottomHStack: UIStackView = .style {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fill
        $0.alignment = .center
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Constants.colors.white
        addSubview(topHStack)
        addSubview(bottomHStack)
        topHStack.addArrangedSubview(sortAlphabetButton)
        topHStack.addArrangedSubview(sortAplphabelLabel)
        bottomHStack.addArrangedSubview(sortBirthdayButton)
        bottomHStack.addArrangedSubview(sortBirthdayLabel)
        
        NSLayoutConstraint.activate([
            sortAlphabetButton.heightAnchor.constraint(equalToConstant: Constants.layout.sortAlphabetButtonHeight),
            sortAlphabetButton.widthAnchor.constraint(equalToConstant: Constants.layout.sortAlphabetButtonWidth),
            sortBirthdayButton.heightAnchor.constraint(equalTo: sortAlphabetButton.heightAnchor),
            sortBirthdayButton.widthAnchor.constraint(equalTo: sortAlphabetButton.widthAnchor),
            
            topHStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.layout.topHStackTop),
            topHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.layout.topHStackLeading),
            topHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.layout.topHstackTrailing),
            topHStack.heightAnchor.constraint(equalToConstant: Constants.layout.topHstackHeight),
            
            bottomHStack.topAnchor.constraint(equalTo: topHStack.bottomAnchor),
            bottomHStack.leadingAnchor.constraint(equalTo: topHStack.leadingAnchor),
            bottomHStack.trailingAnchor.constraint(equalTo: topHStack.trailingAnchor),
            bottomHStack.heightAnchor.constraint(equalTo: topHStack.heightAnchor),
        ])
    }
}
