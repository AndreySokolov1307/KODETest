import Foundation

class Endpoint: IEndpoint {
    var httpMethod: HTTPMethod  = .get
    
    var baseURLString: String = Constants.strings.baseURLString
    
    var path: String = Constants.strings.path
    
    //Выбери headers
    var headers: [String : String] = Constants.strings.headers
    //var headers: [String : String] = Constants.strings.errorHeaders
}


