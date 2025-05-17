//
//  KredivoTopUpViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

final class KredivoTopUpPageViewModel: ObservableObject {
    
    @Published private(set) var tabSelection: Int = 0
    
    let mobileNumberInputViewModel: KredivoMobileNumberInputViewModel
    let mobileCreditListViewModel: KredivoMobileCreditListViewModel
    let promoBannerViewModel: KredivoPromoBannerViewModel
    let dataPackageViewModel: KredivoDataPackageViewModel
    
    private let mobileCreditFetcher: KredivoMobileCreditFetcherProtocol
    
    init(
        mobileCreditFetcher: KredivoMobileCreditFetcherProtocol = KredivoMobileCreditFetcher(),
        voucherFetcher: KredivoVoucherFetcherProtocol = KredivoVoucherFetcher()
    ) {
        self.mobileCreditFetcher = mobileCreditFetcher
        
        mobileNumberInputViewModel = KredivoMobileNumberInputViewModel()
        mobileCreditListViewModel = KredivoMobileCreditListViewModel()
        promoBannerViewModel = KredivoPromoBannerViewModel(voucherFetcher: voucherFetcher)
        dataPackageViewModel = KredivoDataPackageViewModel()
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
        
    }
    
    func onTapVoucher(_ voucher: KredivoVoucherItem) {
        
    }
    
    func setTabSelection(to index: Int) {
        tabSelection = index
    }
}
