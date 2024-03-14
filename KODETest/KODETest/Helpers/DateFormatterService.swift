//
//  ShortDateFormatter.swift
//  KODETest
//
//  Created by Андрей Соколов on 12.03.2024.
//

import Foundation

class DateFormatterService {
    static let shared =  DateFormatterService()
    
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
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    var dayMonthYearFormatter: DateFormatter {
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }
    
    var regularFormatter: DateFormatter {
        formatter.dateFormat = Constants.strings.regularDateFormat
        return formatter
    }
    
    
}
