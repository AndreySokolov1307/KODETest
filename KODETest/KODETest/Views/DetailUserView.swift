//
//  DetailUserView.swift
//  KODETest
//
//  Created by Андрей Соколов on 13.03.2024.
//

import UIKit

class DetailUserView: UIView {
    
    @UseAutolayout var userInfoView = UserInfoView()
    @UseAutolayout var userBirthInfoView : InfoView = .style {
        $0.imageView.image = Constants.images.favorite
    }
    @UseAutolayout var userPhoneNumberView: InfoView = .style {
        $0.imageView.image = Constants.images.phone
    }
    @UseAutolayout var backButton: UIButton = .style {
        $0.setImage(Constants.images.back, for: .normal)
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
        addSubview(userInfoView)
        addSubview(userBirthInfoView)
        addSubview(userPhoneNumberView)
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            userInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userInfoView.topAnchor.constraint(equalTo: topAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            userBirthInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userBirthInfoView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 8),
            userBirthInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            userBirthInfoView.heightAnchor.constraint(equalToConstant: 60),
            
            userPhoneNumberView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userPhoneNumberView.topAnchor.constraint(equalTo: userBirthInfoView.bottomAnchor, constant: 6),
            userPhoneNumberView.heightAnchor.constraint(equalTo: userBirthInfoView.heightAnchor),
        ])
    }
}