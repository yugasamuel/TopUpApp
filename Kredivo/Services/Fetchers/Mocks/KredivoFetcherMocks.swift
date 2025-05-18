//
//  KredivoFetcherMocks.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoMobileCreditFetcherMock: KredivoMobileCreditFetcherProtocol {
    
    var error: KredivoNetworkError?
    var mockResponse: KredivoMobileCreditResponse?
    
    init(mockResponse: KredivoMobileCreditResponse? = nil, error: KredivoNetworkError? = nil) {
        self.mockResponse = mockResponse
    }
    
    func fetch(mobileNumber: String) async throws -> KredivoMobileCreditResponse {
        if let error: KredivoNetworkError = error {
            throw error
        }
        guard let response: KredivoMobileCreditResponse = mockResponse else {
            throw KredivoNetworkError.invalidResponse
        }
        return response
    }
    
    static func loadMock() -> KredivoMobileCreditResponse? {
        guard let url: URL = Bundle.main.url(forResource: "mobile-credit-response-mock", withExtension: "json"),
              let data: Data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? JSONDecoder().decode(KredivoMobileCreditResponse.self, from: data)
    }
}

struct KredivoVoucherFetcherMock: KredivoVoucherFetcherProtocol {
    
    var error: KredivoNetworkError?
    var mockResponse: KredivoVoucherResponse?
    
    init(mockResponse: KredivoVoucherResponse? = nil, error: KredivoNetworkError? = nil) {
        self.mockResponse = mockResponse
    }
    
    func fetch() async throws -> KredivoVoucherResponse {
        if let error: KredivoNetworkError = error {
            throw error
        }
        guard let response: KredivoVoucherResponse = mockResponse else {
            throw KredivoNetworkError.invalidResponse
        }
        return response
    }
    
    static func loadMock() -> KredivoVoucherResponse? {
        guard let url: URL = Bundle.main.url(forResource: "voucher-response-mock", withExtension: "json"),
              let data: Data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? JSONDecoder().decode(KredivoVoucherResponse.self, from: data)
    }
}

struct KredivoStatusFetcherMock: KredivoStatusFetcherProtocol {
    
    var error: KredivoNetworkError?
    var mockResponse: KredivoStatusResponse?
    
    init(mockResponse: KredivoStatusResponse? = nil, error: KredivoNetworkError? = nil) {
        self.mockResponse = mockResponse
    }
    
    func fetch(
        mobileNumber: String,
        mobileCreditProductCode: String,
        mobileCreditLabel: String,
        voucherId: Int?
    ) async throws -> KredivoStatusResponse {
        if let error: KredivoNetworkError = error {
            throw error
        }
        guard let response: KredivoStatusResponse = mockResponse else {
            throw KredivoNetworkError.invalidResponse
        }
        return response
    }
    
    static func loadMock() -> KredivoStatusResponse? {
        guard let url: URL = Bundle.main.url(forResource: "status-page-response-mock", withExtension: "json"),
              let data: Data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? JSONDecoder().decode(KredivoStatusResponse.self, from: data)
    }
}
