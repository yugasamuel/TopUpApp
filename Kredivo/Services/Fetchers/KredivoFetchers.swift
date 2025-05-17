//
//  KredivoFetchers.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoMobileCreditFetcher: KredivoMobileCreditFetcherProtocol {
    func fetch() async throws -> KredivoMobileCreditResponse {
        let endpoint: KredivoEndpoint = KredivoEndpoint.mobileCredit
        
        guard let request: URLRequest = endpoint.request else {
            throw KredivoNetworkError.invalidURL(endpoint.url)
        }
        
        return try await KredivoNetworkService.shared.request(request)
    }
}

struct KredivoVoucherFetcher: KredivoVoucherFetcherProtocol {
    func fetch() async throws -> KredivoVoucherResponse {
        let endpoint: KredivoEndpoint = KredivoEndpoint.voucher
        
        guard let request: URLRequest = endpoint.request else {
            throw KredivoNetworkError.invalidURL(endpoint.url)
        }
        
        return try await KredivoNetworkService.shared.request(request)
    }
}

struct KredivoStatusFetcher: KredivoStatusFetcherProtocol {
    func fetch() async throws -> KredivoStatusResponse {
        let endpoint: KredivoEndpoint = KredivoEndpoint.status
        
        guard let request: URLRequest = endpoint.request else {
            throw KredivoNetworkError.invalidURL(endpoint.url)
        }
        
        return try await KredivoNetworkService.shared.request(request)
    }
}
