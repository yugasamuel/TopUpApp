//
//  KredivoStatusPageViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoStatusPageNavigationDelegate: AnyObject {
    func backToTopUpPage()
}

enum KredivoStatusPageViewModelState {
    case loading
    case loaded(
        response: KredivoStatusResponse,
        mobileNumber: String,
        message: String
    )
    case error(KredivoNetworkError)
}

final class KredivoStatusPageViewModel: ObservableObject {
    
    @Published private(set) var state: KredivoStatusPageViewModelState = .loading
    
    weak var navigationDelegate: KredivoStatusPageNavigationDelegate?
    
    private let mobileNumber: String
    private let mobileCreditProductCode: String
    private let mobileCreditLabel: String
    private let voucherId: Int?
    private let statusFetcher: KredivoStatusFetcherProtocol
    
    init(
        mobileNumber: String,
        mobileCreditProductCode: String,
        mobileCreditLabel: String,
        voucherId: Int?,
        statusFetcher: KredivoStatusFetcherProtocol = KredivoStatusFetcher()
    ) {
        self.mobileNumber = mobileNumber
        self.mobileCreditProductCode = mobileCreditProductCode
        self.mobileCreditLabel = mobileCreditLabel
        self.voucherId = voucherId
        self.statusFetcher = statusFetcher
    }
    
    @MainActor
    func fetchStatus() async {
        state = .loading
        
        do {
            let response: KredivoStatusResponse = try await statusFetcher.fetch(
                mobileNumber: mobileNumber,
                mobileCreditProductCode: mobileCreditProductCode,
                mobileCreditLabel: mobileCreditLabel,
                voucherId: voucherId
            )
            state = .loaded(
                response: response,
                mobileNumber: mobileNumber,
                message: response.message
            )
        }
        catch let error as KredivoNetworkError {
            state = .error(error)
        }
        catch {
            state = .error(.invalidResponse)
        }
    }
    
    func backToTopUpPage() {
        navigationDelegate?.backToTopUpPage()
    }
}
