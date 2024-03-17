//
//  EmptySearchView.swift
//  KODETest
//
//  Created by Андрей Соколов on 11.03.2024.
//

import UIKit

final class EmptySearchView: UIView {
    
    @UseAutolayout var imageView: UIImageView = .style {
        $0.image = Constants.images.magnifier
    }
    
    @UseAutolayout var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = Constants.layout.errorVStackSpacing
    }
    
    let titleLabel: UILabel = .style {
        $0.text = Constants.strings.emptySearchTitle
        $0.font = Constants.fonts.errorTitle
    }
    
    let subtitleLabel: UILabel = .style {
        $0.text = Constants.strings.emptySearchSubtitle
        $0.font = Constants.fonts.errorSubtitle
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
        backgroundColor = Constants.colors.white
        addSubview(vStack)
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)
        vStack.setCustomSpacing(Constants.layout.errorVStackCustomSpasing, after: imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.layout.errorImageSide),
            imageView.heightAnchor.constraint(equalToConstant: Constants.layout.errorImageSide),
            
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: Constants.layout.vStackEmptySearchTop)
        ])
    }
}
