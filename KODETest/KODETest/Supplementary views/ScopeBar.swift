import UIKit

class ScopeBar: UIScrollView {
    
    var scopeButtons: [ScopeButton] = []
    
    var selectedButton: ScopeButton? {
        didSet {
            if oldValue != selectedButton {
                oldValue?.isSelected = false
                selectedButton?.isSelected = true
            }
        }
    }
    
    var selectedDepartment: String {
        (selectedButton?.titleLabel?.text)! 
    }
    
    @UseAutolayout var hStack: UIStackView = .style {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureScrollView() {
        showsHorizontalScrollIndicator = false
        contentInset.left = Constants.layout.scopeBarContentInsetLeft
        addSubview(hStack)
        for department in Department.allCases {
            let scopeButton = ScopeButton()
            scopeButton.setTitle(department.title, for: .normal)
            hStack.addArrangedSubview(scopeButton)
            scopeButtons.append(scopeButton)
        }
        selectedButton = scopeButtons.first
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            hStack.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
