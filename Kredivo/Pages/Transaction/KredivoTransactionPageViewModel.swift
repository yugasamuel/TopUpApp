//
//  KredivoTransactionPageViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoTransactionPageNavigationDelegate: AnyObject {
    func navigateToVoucherPage(
        voucherFetcher: KredivoVoucherFetcherProtocol,
        delegate: KredivoVoucherListPageViewModelDelegate?
    )
    func navigateToStatusPage(
        mobileNumber: String,
        mobileCreditProductCode: String,
        mobileCreditLabel: String,
        voucherId: Int?
    )
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
        guard pinInputViewModel.isPinValid else { return }
        
        let selectedVoucher: KredivoVoucherItem? = switch voucherInputViewModel.state {
        case .empty:
            nil
        case .filled(let voucher):
            voucher
        }
        
        navigationDelegate?.navigateToStatusPage(
            mobileNumber: mobileNumber,
            mobileCreditProductCode: mobileCredit.productCode,
            mobileCreditLabel: mobileCredit.label,
            voucherId: selectedVoucher?.id
        )
    }
    
    func navigateToVoucherPage() {
        navigationDelegate?.navigateToVoucherPage(voucherFetcher: voucherFetcher, delegate: self)
    }
    
    func processVoucherRemoval() {
        voucherInputViewModel.setVoucherState(.empty)
        transactionDetailsViewModel.setVoucher(nil)
    }
}

// MARK: - KredivoVoucherListPageViewModelDelegate

extension KredivoTransactionPageViewModel: KredivoVoucherListPageViewModelDelegate {
    func didUseVoucher(_ voucher: KredivoVoucherItem) {
        voucherInputViewModel.setVoucherState(.filled(voucher))
        transactionDetailsViewModel.setVoucher(voucher)
    }
}
