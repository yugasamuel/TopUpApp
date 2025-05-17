//
//  KredivoNetworkService.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoNetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: URLRequest) async throws -> T
}

final class KredivoNetworkService: KredivoNetworkServiceProtocol {
    static let shared: KredivoNetworkServiceProtocol = KredivoNetworkService()
    
    private init() { }
    
    func request<T: Decodable>(_ endpoint: URLRequest) async throws -> T {
        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: endpoint)
        
        guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
            throw KredivoNetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw KredivoNetworkError.statusCode(httpResponse.statusCode)
        }
        
        do {
            let decoded: T = try JSONDecoder().decode(T.self, from: data)
            return decoded
        }
        catch {
            throw KredivoNetworkError.decodingFailed(error)
        }
    }
}
