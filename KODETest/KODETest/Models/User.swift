import Foundation

struct UserResponce: Codable {
    var items: [User]
}

struct User: Codable {
    let id: String
    let avatarUrl: String
    let firstName: String
    let lastName: String
    let userTag: String
    let department: Department
    let position: String
    let birthday: String
    let phone: String
    
    var fullName: String {
        firstName + Constants.strings.space + lastName
    }
    
    func getAgeFromatted() -> String {
        let dcf = DateComponentsFormatter()
        dcf.allowedUnits = .year
        dcf.unitsStyle = .full
        let age = dcf.string(from: birthdayDate!, to: Date())
        return age!
    }
    
    var birthdayDate: Date? {
        return DateFormatterManager().regularFormatter.date(from: birthday)
    }
    
    var birthdayDateForSort: Date? {
        guard let date = birthdayDate else { return nil }
        let string = DateFormatterManager().shortFormater.string(from: date)
        return   DateFormatterManager().shortFormater.date(from: string)
    }
}

