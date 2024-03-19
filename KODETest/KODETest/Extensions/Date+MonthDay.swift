import Foundation

extension Date {
    struct MonthDay: Comparable {
        let month: Int
        let day: Int
        
        init(date: Date) {
            let comps = Calendar.current.dateComponents([.month,.day], from: date)
            self.month = comps.month ?? 0
            self.day = comps.day ?? 0
        }
        
        static func <(lhs: MonthDay, rhs: MonthDay) -> Bool {
            return (lhs.month < rhs.month || (lhs.month == rhs.month && lhs.day < rhs.day))
        }
    }
}
