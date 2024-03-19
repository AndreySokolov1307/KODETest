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
            imageView.heightAnchor.constraint(equalToConstant: Constants.layout.infoViewImageSide),
            imageView.widthAnchor.constraint(equalToConstant: Constants.layout.infoViewImageSide),
            
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.layout.infoViewLabelLeading),
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            extraInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.layout.infoViewExtraLabelTrailing),
            extraInfoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
