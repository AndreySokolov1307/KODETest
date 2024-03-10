//
//  UIVIew+Style.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit
extension UIView {
    static func style<T: UIView>(_  style: @escaping (T) -> Void) -> T {
        let view = T()
        style(view)
        return view
    }
}
