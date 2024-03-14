//
//  InfoView.swift
//  KODETest
//
//  Created by Андрей Соколов on 13.03.2024.
//

import UIKit

class InfoView: UIView {
    
    @UseAutolayout var imageView = UIImageView ()
    
    @UseAutolayout var infoLabel: UILabel = .style {
        $0.font = Constants.fonts.infoLabel
        $0.textColor = Constants.colors.black2
    }
    
    @UseAutolayout var extraInfoLabel: UILabel = .style {
        $0.font = Constants.fonts.bithDateLabel
        $0.textColor = Constants.colors.grey
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(imageView)
        addSubview(infoLabel)
        addSubview(extraInfoLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            extraInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            extraInfoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
