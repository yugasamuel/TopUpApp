//
//  KredivoNetworkError.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

enum KredivoNetworkError: Error, LocalizedError {
    case invalidResponse
    case statusCode(Int)
    case decodingFailed(Error)
    case invalidURL(URL?)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server."
        case .statusCode(let code):
            return "Request failed with status code \(code)."
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .invalidURL(let url):
            return "Invalid URL request: \(String(describing: url))"
        }
    }
}
