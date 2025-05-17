//
//  KredivoPromoBannerViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

enum KredivoPromoBannerViewModelState {
    case loading
    case loaded([KredivoVoucherItem])
    case error(KredivoNetworkError)
}

final class KredivoPromoBannerViewModel: ObservableObject {
    
    @Published private(set) var state: KredivoPromoBannerViewModelState = .loading
    
    private let voucherFetcher: KredivoVoucherFetcherProtocol
    
    init(voucherFetcher: KredivoVoucherFetcherProtocol = KredivoVoucherFetcher()) {
        self.voucherFetcher = voucherFetcher
    }
    
    @MainActor
    func fetchVouchers() async {
        state = .loading
        
        do {
            let response: KredivoVoucherResponse = try await voucherFetcher.fetch()
            state = .loaded(response.data)
        }
        catch let error as KredivoNetworkError {
            state = .error(error)
        }
        catch {
            state = .error(.invalidResponse)
        }
    }
}
