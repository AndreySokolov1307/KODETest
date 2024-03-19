import UIKit

class DetailUserView: UIView {
    
    @UseAutolayout var userInfoView = UserInfoView()
    @UseAutolayout var userBirthInfoView : InfoView = .style {
        $0.imageView.image = Constants.images.favorite
    }
    @UseAutolayout var userPhoneNumberView: InfoView = .style {
        $0.imageView.image = Constants.images.phone
    }
    @UseAutolayout var backButton: UIButton = .style {
        $0.setImage(Constants.images.back, for: .normal)
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
        addSubview(userInfoView)
        addSubview(userBirthInfoView)
        addSubview(userPhoneNumberView)
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.layout.detailBackButtonLeading),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.layout.detailBackButtonTop),
            backButton.heightAnchor.constraint(equalToConstant: Constants.layout.detailBackButtonSide),
            backButton.widthAnchor.constraint(equalToConstant: Constants.layout.detailBackButtonSide),
            
            userInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userInfoView.topAnchor.constraint(equalTo: topAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            userBirthInfoView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.layout.birthInfoViewLeading),
            userBirthInfoView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: Constants.layout.birthInfoTop),
            userBirthInfoView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.layout.birthDateLabelTrailing),
            userBirthInfoView.heightAnchor.constraint(equalToConstant: Constants.layout.birthInfoHeight),
            
            userPhoneNumberView.leadingAnchor.constraint(equalTo: userBirthInfoView.leadingAnchor),
            userPhoneNumberView.topAnchor.constraint(equalTo: userBirthInfoView.bottomAnchor, constant: Constants.layout.phoneInfoTop),
            userPhoneNumberView.heightAnchor.constraint(equalTo: userBirthInfoView.heightAnchor),
            userPhoneNumberView.trailingAnchor.constraint(equalTo: userPhoneNumberView.infoLabel.trailingAnchor),
        ])
    }
}
