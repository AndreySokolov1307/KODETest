import UIKit

class SortView: UIView {
    
    @UseAutolayout var alphabetOptionView: OptionView = .style {
        $0.optionLabel.text = Constants.strings.sortAlphabet
    }

    @UseAutolayout var birthdayOptionView: OptionView = .style {
        $0.optionLabel.text = Constants.strings.sortBirthday
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Constants.colors.white
        addSubview(alphabetOptionView)
        addSubview(birthdayOptionView)
        
        NSLayoutConstraint.activate([
            alphabetOptionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.layout.optionViewLeading),
            alphabetOptionView.trailingAnchor.constraint(equalTo: alphabetOptionView.optionLabel.trailingAnchor),
            alphabetOptionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.layout.optionViewTop),
            alphabetOptionView.heightAnchor.constraint(equalToConstant: Constants.layout.optionViewHeight),
            
            birthdayOptionView.leadingAnchor.constraint(equalTo: alphabetOptionView.leadingAnchor),
            birthdayOptionView.topAnchor.constraint(equalTo: alphabetOptionView.bottomAnchor),
            birthdayOptionView.trailingAnchor.constraint(equalTo: birthdayOptionView.optionLabel.trailingAnchor),
            birthdayOptionView.heightAnchor.constraint(equalTo: alphabetOptionView.heightAnchor)
        ])
    }
}
