import UIKit

enum Constants {
    enum functions {
        static func getNextYearString() -> String {
            let calendar = Calendar.current
            guard let newDate = calendar.date(byAdding: .year, value: 1, to: Date()) else {
                return "Next year"
            }
            return DateFormatterManager().yearFormater.string(from: newDate)
        }
    }
}

