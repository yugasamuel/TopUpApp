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
    
    func fetch() async throws -> KredivoMobileCreditResponse {
        if let error: KredivoNetworkError = error {
            throw error
        }
        guard let response: KredivoMobileCreditResponse = mockResponse else {
            throw KredivoNetworkError.invalidResponse
        }
        return response
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
}

struct KredivoStatusFetcherMock: KredivoStatusFetcherProtocol {
    var error: KredivoNetworkError?
    var mockResponse: KredivoStatusResponse?
    
    init(mockResponse: KredivoStatusResponse? = nil, error: KredivoNetworkError? = nil) {
        self.mockResponse = mockResponse
    }
    
    func fetch() async throws -> KredivoStatusResponse {
        if let error: KredivoNetworkError = error {
            throw error
        }
        guard let response: KredivoStatusResponse = mockResponse else {
            throw KredivoNetworkError.invalidResponse
        }
        return response
    }
}
