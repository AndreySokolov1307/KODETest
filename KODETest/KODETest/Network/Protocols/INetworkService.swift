import UIKit

protocol INetworkService {
    var endpoint: IEndpoint { get }
    
    func fetchUsers() async throws -> [User]
    func fetchImage(from url: URL) async throws -> UIImage?
}
