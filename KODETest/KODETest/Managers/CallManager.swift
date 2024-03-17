//
//  CallManager.swift
//  KODETest
//
//  Created by Андрей Соколов on 14.03.2024.
//

import UIKit

final class CallService {
    static let shared = CallService()
    
    func callNumber(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
