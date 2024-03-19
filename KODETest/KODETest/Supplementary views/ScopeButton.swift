import UIKit

class ScopeButton: UIButton {
    
    @UseAutolayout var lineView = UIView()
    var widthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            lineView.backgroundColor = isSelected ? Constants.colors.purple: Constants.colors.white
            titleLabel?.font = isSelected ? Constants.fonts.selectedScope :
            Constants.fonts.plainScope
            titleLabel?.tintColor = isSelected ? Constants.colors.black : Constants.colors.grey
        }
    }
    
    private func configureButton() {
        titleLabel?.adjustsFontSizeToFitWidth = true
        setTitleColor(.black, for: .selected)
        setTitleColor(.systemGray, for: .normal)
        contentEdgeInsets = Constants.layout.scopeButtonContentInsets
        titleLabel?.font = Constants.fonts.plainScope
        addSubview(lineView)
        lineView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Constants.layout.departmentCellLineViewHeight),
        ])
    }
}
