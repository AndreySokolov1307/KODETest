//
//  UIViewVontroller+Alert.swift
//  KODETest
//
//  Created by Андрей Соколов on 14.03.2024.
//

import UIKit

extension UIViewController {
    func presentActionSheetAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
     
    
        for action in actions {
            alert.addAction(action)
        }
        alert.view.tintColor = Constants.colors.black3
        self.present(alert, animated: true)
    }
}
