//
//  KredivoFetchers.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoMobileCreditFetcher: KredivoMobileCreditFetcherProtocol {
    func fetch(mobileNumber: String) async throws -> KredivoMobileCreditResponse {
        let endpoint: KredivoEndpoint = KredivoEndpoint.mobileCredit(mobileNumber: mobileNumber)
        
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
    func fetch(
        mobileNumber: String,
        mobileCreditProductCode: String,
        mobileCreditLabel: String,
        voucherId: Int?
    ) async throws -> KredivoStatusResponse {
        let endpoint: KredivoEndpoint = KredivoEndpoint.status(
            mobileNumber: mobileNumber,
            mobileCreditProductCode: mobileCreditProductCode,
            mobileCreditLabel: mobileCreditLabel,
            voucherId: voucherId
        )
        
        guard let request: URLRequest = endpoint.request else {
            throw KredivoNetworkError.invalidURL(endpoint.url)
        }
        
        return try await KredivoNetworkService.shared.request(request)
    }
}
