//
//  KredivoVoucherListPageViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoVoucherListPageNavigationDelegate: AnyObject {
    func navigateToVoucherDetail(_ voucher: KredivoVoucherItem)
    func backToPreviousPage()
}

protocol KredivoVoucherListPageViewModelDelegate: AnyObject {
    func didUseVoucher(_ voucher: KredivoVoucherItem)
}

enum KredivoVoucherListPageViewModelState {
    case loading
    case loaded([KredivoVoucherItem])
    case error(KredivoNetworkError)
}

final class KredivoVoucherListPageViewModel: ObservableObject {
    
    weak var navigationDelegate: KredivoVoucherListPageNavigationDelegate?
    weak var delegate: KredivoVoucherListPageViewModelDelegate?
    
    @Published private(set) var state: KredivoVoucherListPageViewModelState = .loading
    
    let voucherFetcher: KredivoVoucherFetcherProtocol
    
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
    
    func navigateToVoucherDetail(_ voucher: KredivoVoucherItem) {
        navigationDelegate?.navigateToVoucherDetail(voucher)
    }
    
    func didUseVoucher(_ voucher: KredivoVoucherItem) {
        delegate?.didUseVoucher(voucher)
        navigationDelegate?.backToPreviousPage()
    }
}
