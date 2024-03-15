//
//  DetailUserViewController.swift
//  KODETest
//
//  Created by Андрей Соколов on 13.03.2024.
//

import UIKit

final class DetailUserViewController: UIViewController {
    
    private lazy var detailUserView = DetailUserView()
    private var user: User
    private var networkService: INetworkService
    private var imageTask: Task<Void, Never>? = nil
    
    init(user: User, networkService: INetworkService) {
        self.user = user
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailUserView
    }
    
    override func viewDidLoad() {
        setupUI()
        addTargets()
    }
    
    private func setupUI() {
        imageTask = Task {
            do {
                if let url = URL(string: user.avatarUrl) {
                    let image = try await networkService.fetchImage(from: url)
                    detailUserView.userInfoView.avatarImageView.image = image
                } else {
                    detailUserView.userInfoView.avatarImageView.image = Constants.images.stub
                }
            } catch {
                detailUserView.userInfoView.avatarImageView.image = Constants.images.stub
            }
        }
        detailUserView.userInfoView.nameLabel.text = user.fullName
        detailUserView.userInfoView.positionLabel.text = user.position
        detailUserView.userInfoView.userTagLabel.text = user.userTag.lowercased()
        
        detailUserView.userBirthInfoView.infoLabel.text = DateFormatterService().dayMonthYearFormatter.string(from: user.birthdayDate!)
        detailUserView.userBirthInfoView.extraInfoLabel.text = user.getAgeFromatted()
        
        detailUserView.userPhoneNumberView.infoLabel.text = user.phone
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addTargets() {
        detailUserView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapPhoneView(_:)))
        detailUserView.isUserInteractionEnabled = true
        detailUserView.userPhoneNumberView.addGestureRecognizer(tap)
    }
    
    @objc func didTapPhoneView(_ sender: UITapGestureRecognizer) {
        let makePhoneCallAction = UIAlertAction(title: user.phone,
                                                style: .default,
                                            handler: { _ in
            CallManager.shared.callNumber(phoneNumber: self.user.phone)
        })
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel)
        presentActionSheetAlert(title: nil,
                                message: nil,
                                actions: [makePhoneCallAction, cancelAction])
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
