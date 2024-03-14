//
//  Constants.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit

enum Constants {
    enum functions {
        static func getNextYearString() -> String {
            let calendar = Calendar.current
            guard let newDate = calendar.date(byAdding: .year, value: 1, to: Date()) else {
                return "Next year"
            }
            let formatter = DateFormatterService()
            return formatter.yearFormater.string(from: newDate)
        }
    }
}

