//
//  UserCell.swift
//  KODETest
//
//  Created by Андрей Соколов on 10.03.2024.
//

import UIKit

class UserCell: UITableViewCell {
    static var reuseIdentifier = "UserCell"
    
    @UseAutolayout var avatarImageView: UIImageView = .style {
        $0.layer.cornerRadius = 36
        $0.layer.masksToBounds = true
    }
    
    @UseAutolayout var birthDateLabel: UILabel = .style {
        $0.font = Constants.fonts.bithDateLabel
        $0.textColor = Constants.colors.darkGrey
    }
    
    @UseAutolayout var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 3
    }
    
    var nameLabel: UILabel = .style {
        $0.font = Constants.fonts.titleLabel
    }
    
    let positionLabel: UILabel = .style {
        $0.font = Constants.fonts.subtitleLabel
        $0.textColor = Constants.colors.darkGrey
    }
    
    let userTagLabel: UILabel = .style {
        $0.font = Constants.fonts.userTagLabel
        $0.textColor = Constants.colors.grey
    }
    
    let hStack: UIStackView = .style {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.alignment = .fill
        $0.spacing = 4
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(avatarImageView)
        addSubview(vStack)
        addSubview(birthDateLabel)
        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(positionLabel)
        hStack.addArrangedSubview(nameLabel)
        hStack.addArrangedSubview(userTagLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.layout.avatarImageTop),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.layout.avatarImageLeading),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.layout.avatarImageBottom),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.layout.avatarImageHeight),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.layout.avatarImageWidth),
           
            vStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: Constants.layout.vStackLeading),
           vStack.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
           vStack.trailingAnchor.constraint(equalTo: birthDateLabel.leadingAnchor),
           
            birthDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.layout.birthDateLabelTrailing),
           birthDateLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
        ])
    }
}

//MARK: - UserDisplaying

extension UserCell: UserDisplaying {}
