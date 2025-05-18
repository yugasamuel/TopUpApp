//
//  KredivoTopUpViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoTopUpPageNavigationDelegate: AnyObject {
    func navigateToTransactionPage(
        mobileNumber: String,
        mobileCredit: KredivoMobileCreditProduct,
        voucherFetcher: KredivoVoucherFetcherProtocol
    )
    func navigateToVoucherDetail(voucher: KredivoVoucherItem)
}

final class KredivoTopUpPageViewModel: ObservableObject {
    
    @Published private(set) var tabSelection: Int = 0
    
    weak var navigationDelegate: KredivoTopUpPageNavigationDelegate?
    
    let mobileNumberInputViewModel: KredivoMobileNumberInputViewModel
    let mobileCreditListViewModel: KredivoMobileCreditListViewModel
    let promoBannerViewModel: KredivoPromoBannerViewModel
    
    private let mobileCreditFetcher: KredivoMobileCreditFetcherProtocol
    private let voucherFetcher: KredivoVoucherFetcherProtocol
    
    init(
        mobileCreditFetcher: KredivoMobileCreditFetcherProtocol = KredivoMobileCreditFetcher(),
        voucherFetcher: KredivoVoucherFetcherProtocol = KredivoVoucherFetcher()
    ) {
        self.mobileCreditFetcher = mobileCreditFetcher
        self.voucherFetcher = voucherFetcher
        
        mobileNumberInputViewModel = KredivoMobileNumberInputViewModel()
        mobileCreditListViewModel = KredivoMobileCreditListViewModel()
        promoBannerViewModel = KredivoPromoBannerViewModel(voucherFetcher: voucherFetcher)
    }
    
    @MainActor
    func fetchMobileCredits() async {
        mobileCreditListViewModel.setState(.loading)
        
        do {
            let response: KredivoMobileCreditResponse = try await mobileCreditFetcher.fetch(
                mobileNumber: mobileNumberInputViewModel.mobileNumber)
             mobileCreditListViewModel.setState(.loaded(response.products))
        }
        catch let error as KredivoNetworkError {
            mobileCreditListViewModel.setState(.error(error))
        }
        catch {
            mobileCreditListViewModel.setState(.error(.invalidResponse))
        }
    }
    
    func updateStateForInvalidMobileNumber() {
        mobileCreditListViewModel.setState(.invalidMobileNumber)
    }
    
    func onTapProduct(_ product: KredivoMobileCreditProduct) {
        navigationDelegate?.navigateToTransactionPage(
            mobileNumber: mobileNumberInputViewModel.mobileNumber,
            mobileCredit: product,
            voucherFetcher: voucherFetcher
        )
    }
    
    func onTapVoucher(_ voucher: KredivoVoucherItem) {
        navigationDelegate?.navigateToVoucherDetail(voucher: voucher)
    }
    
    func setTabSelection(to index: Int) {
        tabSelection = index
    }
}
