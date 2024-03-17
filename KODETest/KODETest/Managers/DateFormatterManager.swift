//
//  ShortDateFormatter.swift
//  KODETest
//
//  Created by Андрей Соколов on 12.03.2024.
//

import Foundation

class DateFormatterManager {
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        return formatter
    }()
    
    var shortFormater: DateFormatter {
        formatter.dateFormat = Constants.strings.shortDateFormat
        return formatter
    }
    
    var yearFormater: DateFormatter {
        formatter.dateFormat = Constants.strings.yearFormat
        return formatter
    }
    
    var dayMonthYearFormatter: DateFormatter {
        formatter.dateFormat = Constants.strings.dayMonthYearFormat
        return formatter
    }
    
    var regularFormatter: DateFormatter {
        formatter.dateFormat = Constants.strings.regularDateFormat
        return formatter
    }
}
