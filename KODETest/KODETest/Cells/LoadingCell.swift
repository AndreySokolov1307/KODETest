//
//  LoadingCell.swift
//  KODETest
//
//  Created by Андрей Соколов on 10.03.2024.
//

import UIKit

class LoadingCell: UITableViewCell {
    static var reuseIdentifier = Constants.strings.loadingCellReuseIdentifier
    
    @UseAutolayout var avatarView: UIView = .style {
        $0.layer.cornerRadius = Constants.layout.avatarViewCornerRadius
        $0.layer.masksToBounds = true
    }
    
    @UseAutolayout var titleView: UIView = .style {
        $0.layer.cornerRadius = Constants.layout.titleViewCornerRadius
        $0.layer.masksToBounds = true
    }
    
    @UseAutolayout var subtitleView: UIView = .style {
        $0.layer.cornerRadius = Constants.layout.subtitleViewCornerRadius
        $0.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        selectionStyle = .none
        addSubview(avatarView)
        addSubview(titleView)
        addSubview(subtitleView)
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.layout.avatarViewTop),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.layout.avatarViewLeading),
            avatarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.layout.avatarViewBottom),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.layout.avatarViewHeight),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.layout.avatarViewWidth),
            
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.layout.titleViewTop),
            titleView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Constants.layout.titleViewLeading),
            titleView.heightAnchor.constraint(equalToConstant: Constants.layout.titleViewHeight),
            titleView.widthAnchor.constraint(equalToConstant: Constants.layout.titleViewWidth),
            
            subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.layout.subtitleViewTop),
            subtitleView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            subtitleView.heightAnchor.constraint(equalToConstant: Constants.layout.subtitleViewHeight),
            subtitleView.widthAnchor.constraint(equalToConstant: Constants.layout.subtitleViewWidth),
        ])
    }
    
    func addGradient() {
        let colors = [Constants.colors.lightGrey3?.cgColor, Constants.colors.white.cgColor]
        let gradientAvatar = CAGradientLayer()
        let gradientTitle = CAGradientLayer()
        let gradientSubtitle = CAGradientLayer()
        let startPoint = Constants.layout.gradientStartPoint
        let endPoint = Constants.layout.gradientEndPoint
        let gradients = [gradientAvatar, gradientTitle, gradientSubtitle].forEach { gradient in
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
            gradient.colors = colors
        }
        
        gradientAvatar.frame = avatarView.bounds
        avatarView.layer.insertSublayer(gradientAvatar, at: 0)
        
        gradientTitle.frame = titleView.bounds
        titleView.layer.insertSublayer(gradientTitle, at: 0)
        
        gradientSubtitle.frame = subtitleView.bounds
        subtitleView.layer.insertSublayer(gradientSubtitle, at: 0)
    }
}
