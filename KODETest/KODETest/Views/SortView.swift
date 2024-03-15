//
//  SortView.swift
//  KODETest
//
//  Created by Андрей Соколов on 11.03.2024.
//

import UIKit

class SortView: UIView {
    
    @UseAutolayout var alphabetOptionView: SortOptionView = .style {
        $0.optionLabel.text = Constants.strings.sortAlphabet
    }

    @UseAutolayout var birthdayOptionView: SortOptionView = .style {
        $0.optionLabel.text = Constants.strings.sortBirthday
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
        addSubview(alphabetOptionView)
        addSubview(birthdayOptionView)
        
        NSLayoutConstraint.activate([
            alphabetOptionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            alphabetOptionView.trailingAnchor.constraint(equalTo: alphabetOptionView.optionLabel.trailingAnchor),
            alphabetOptionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            alphabetOptionView.heightAnchor.constraint(equalToConstant: 60),
            
            birthdayOptionView.leadingAnchor.constraint(equalTo: alphabetOptionView.leadingAnchor),
            birthdayOptionView.topAnchor.constraint(equalTo: alphabetOptionView.bottomAnchor),
            birthdayOptionView.trailingAnchor.constraint(equalTo: birthdayOptionView.optionLabel.trailingAnchor),
            birthdayOptionView.heightAnchor.constraint(equalTo: alphabetOptionView.heightAnchor)
        ])
    }
}
