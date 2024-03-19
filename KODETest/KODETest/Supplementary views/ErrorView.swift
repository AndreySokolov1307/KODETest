import UIKit

class ErrorView: UIView {
    
    @UseAutolayout var imageView: UIImageView = .style {
        $0.image = Constants.images.flyingSaucer
    }
    @UseAutolayout var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = Constants.layout.errorVStackSpacing
    }
    
    let titleLabel: UILabel = .style {
        $0.text = Constants.strings.errorTitle
        $0.font = Constants.fonts.errorTitle
    }
    
    let subtitleLabel: UILabel = .style {
        $0.text = Constants.strings.errorSubtitle
        $0.font = Constants.fonts.errorSubtitle
        $0.textColor = Constants.colors.grey
    }
    
    let tryAgainButton: UIButton = .style {
        $0.setTitle(Constants.strings.tryAgainButton, for: .normal)
        $0.titleLabel?.font = Constants.fonts.tryAgainButton
        $0.setTitleColor(Constants.colors.purple, for: .normal)
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
        vStack.addArrangedSubview(tryAgainButton)
        
        vStack.setCustomSpacing(Constants.layout.errorVStackCustomSpasing, after: imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.layout.errorImageSide),
            imageView.heightAnchor.constraint(equalToConstant: Constants.layout.errorImageSide),
            
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
