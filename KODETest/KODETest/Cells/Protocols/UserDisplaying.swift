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
    func configure(for user: User, networkService: INetworkService) async {
        nameLabel.text = user.fullName
        positionLabel.text = user.position
        userTagLabel.text = user.userTag.lowercased()
        avatarImageView.image = Constants.images.stub
        if let date = user.birthdayDate {
            birthDateLabel.text = DateFormatterManager().shortFormater.string(from: date)
        }
        guard let url = URL(string: user.avatarUrl) else { return }
        
        do {
            let image = try await networkService.fetchImage(from: url)
            avatarImageView.image = image
        } catch let error as NSError where error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
            // ignore cancellation errors
        } catch {
            avatarImageView.image = Constants.images.stub
            print(error.localizedDescription)
        }
    }
}

