//
//  NetworkService.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit

enum NetworkErrors: Error {
    case invalidURL
}

protocol INetworkService {
    var endpoint: IEndpoint { get }
    
    func fetchUsers() async throws -> [User]
    func fetchImage(from url: URL) async throws -> UIImage?
}

class NetworkService: INetworkService {
    var endpoint: IEndpoint
    
    func fetchImage(from url: URL) async throws -> UIImage? {
        
    }
}
