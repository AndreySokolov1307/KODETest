import UIKit

final class CallService {
    static let shared = CallService()
    
    func callNumber(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
