//
//  ShortDateFormatter.swift
//  KODETest
//
//  Created by Андрей Соколов on 12.03.2024.
//

import Foundation

class ShortDateFomatter: DateFormatter {
    override init() {
        super.init()
        setupDateFormatter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDateFormatter() {
        dateFormat = Constants.strings.shortDateFormat
        timeZone = .current
    }
}
