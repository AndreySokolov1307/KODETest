//
//  UserDisplaying.swift
//  KODETest
//
//  Created by Андрей Соколов on 10.03.2024.
//

import UIKit

protocol UserDisplaying {
    var avatarImageView: UIImageView { get }
    var nameLabel: UILabel { get }
    var positionLabel: UILabel { get }
    var userTagLabel: UILabel { get }
    var birthDateLabel: UILabel { get }
}

@MainActor
extension UserDisplaying {
    func configure(for user: User,with networkService: INetworkService) async {
        nameLabel.text = user.fullName
        positionLabel.text = user.position
        userTagLabel.text = user.userTag.lowercased()
        avatarImageView.image = Constants.images.stub
        if let date = user.birthdayDate {
            birthDateLabel.text = DateFormatterService().shortFormater.string(from: date)
        }
        guard let url = URL(string: user.avatarUrl) else { return }
        
        do {
            let image = try await networkService.fetchImage(from: url)
            avatarImageView.image = image
        } catch {
            print(error.localizedDescription)
        }
    }
}

