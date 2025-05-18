//
//  KredivoTransactionPageViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoTransactionPageNavigationDelegate: AnyObject {
    func navigateToStatusPage()
    func navigateToVoucherPage()
}

final class KredivoTransactionPageViewModel {
    
    weak var navigationDelegate: KredivoTransactionPageNavigationDelegate?
    
    let transactionDetailsViewModel: KredivoTransactionDetailsViewModel
    let pinInputViewModel: KredivoPinInputViewModel
    let voucherInputViewModel: KredivoVoucherInputViewModel
    let mobileNumber: String
    let mobileCredit: KredivoMobileCreditProduct
    private let voucherFetcher: KredivoVoucherFetcherProtocol
    
    init(
        mobileNumber: String,
        mobileCredit: KredivoMobileCreditProduct,
        voucherFetcher: KredivoVoucherFetcherProtocol = KredivoVoucherFetcher()
    ) {
        self.mobileNumber = mobileNumber
        self.mobileCredit = mobileCredit
        self.voucherFetcher = voucherFetcher
        
        transactionDetailsViewModel = KredivoTransactionDetailsViewModel(mobileCredit: mobileCredit)
        pinInputViewModel = KredivoPinInputViewModel()
        voucherInputViewModel = KredivoVoucherInputViewModel()
    }
    
    func validateTransaction() {
        navigationDelegate?.navigateToStatusPage()
    }
    
    func navigateToVoucherPage() {
        navigationDelegate?.navigateToVoucherPage()
    }
}
