import UIKit

class UserInfoView: UIView {
    
    @UseAutolayout var avatarImageView: UIImageView = .style {
        $0.layer.cornerRadius = Constants.layout.avatarImageCornerRadius
        $0.clipsToBounds = true
    }
    
    @UseAutolayout private var containerView: UIView = .style {
        $0.clipsToBounds = false
        $0.layer.cornerRadius = Constants.layout.avatarImageCornerRadius
        $0.layer.shadowOffset = Constants.layout.containerViewShadowOffset
        $0.layer.shadowRadius = Constants.layout.containerViewShadowRadius
        $0.layer.shadowColor = Constants.colors.shadow?.cgColor
        $0.layer.shadowOpacity = Constants.layout.containerViewShadowOpacity
    }
    
    @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = Constants.layout.userInfoVStackSpacing
    }
    
    var nameLabel: UILabel = .style {
        $0.font = Constants.fonts.detailTitleLabel
        $0.textColor = Constants.colors.black2
    }
    
    @UseAutolayout var positionLabel: UILabel = .style {
        $0.font = Constants.fonts.detailSubtitleLabel
        $0.textColor = Constants.colors.darkGrey
    }
    
    let userTagLabel: UILabel = .style {
        $0.font = Constants.fonts.detailUserTagLabel
        $0.textColor = Constants.colors.grey
    }
    
    private let hStack: UIStackView = .style {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.alignment = .fill
        $0.spacing = Constants.layout.userInfoHStackSpacing
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        avatarImageView.frame = containerView.bounds
    }
    
    private func configureView() {
        backgroundColor = Constants.colors.background
        containerView.addSubview(avatarImageView)
        addSubview(containerView)
        addSubview(vStack)
        addSubview(positionLabel)
        vStack.addArrangedSubview(hStack)
        hStack.addArrangedSubview(nameLabel)
        hStack.addArrangedSubview(userTagLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.layout.containerViewTop),
            containerView.heightAnchor.constraint(equalToConstant: Constants.layout.containerViewSide),
            containerView.widthAnchor.constraint(equalToConstant: Constants.layout.containerViewSide),
            
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            
            positionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            positionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.layout.positionLabelBottom),
        
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.bottomAnchor.constraint(equalTo: positionLabel.topAnchor, constant: Constants.layout.userInfoVStackBottom),
            vStack.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.layout.userInfoVStackTop),
            
            heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.layout.userInfoMinHeight)
        ])
    }
}
