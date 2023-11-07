//
//  NetworkManager.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 07.11.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case invalidData
    case invalidResponse
}


struct APIConstants {
    static let beveragesStringURL = "https://api.jsonserve.com/r7NDYL"
    static let dessertsStringURL = "https://api.jsonserve.com/ml3jCF"
    static let bestProducts = "https://api.jsonserve.com/QwxDSb"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getProducts(from url: String) async throws -> [Product] {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
        
    }
    
    
    
    private init() {}
    
}
