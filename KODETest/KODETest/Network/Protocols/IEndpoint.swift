import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol IEndpoint {
    var httpMethod: HTTPMethod { get set }
    var baseURLString: String { get set }
    var path: String { get set }
    var headers: [ String : String ]  { get set }
}

extension IEndpoint {
    var url: String {
        return baseURLString + path
    }
}

