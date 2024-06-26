import UIKit

enum NetworkErrors: Error {
    case invalidURL
    case usersNotFound
    case imageDataMissing
}

final class NetworkService: INetworkService {
    
    var endpoint: IEndpoint = Endpoint()
    private lazy var imageCacheManager = ImageCacheManager()
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: endpoint.url) else {
            throw NetworkErrors.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        let (data, responce) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = responce as? HTTPURLResponse, httpResponse.statusCode == Constants.numbers.statusCodeSuccess else {
            throw NetworkErrors.usersNotFound
        }
        
        let userResponce = try JSONDecoder().decode(UserResponce.self, from: data)
        return userResponce.items
    }
    
    func fetchImage(from url: URL) async throws -> UIImage? {
        if let cachedImage = imageCacheManager.getImage(for: url) {
            return cachedImage
        } else {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == Constants.numbers.statusCodeSuccess else {
                throw NetworkErrors.imageDataMissing
            }
            
            guard let image = UIImage(data: data) else {
                throw NetworkErrors.imageDataMissing
            }
            imageCacheManager.saveImage(image, withURL: url)
            return image
        }
    }
}
