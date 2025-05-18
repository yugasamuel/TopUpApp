//
//  KredivoAppCoordinator.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import Foundation
import UIKit

final class KredivoAppCoordinator: KredivoCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        var mobileCreditFetcher: KredivoMobileCreditFetcherMock = KredivoMobileCreditFetcherMock()
        mobileCreditFetcher.mockResponse = KredivoMobileCreditFetcherMock.loadMock()
        
        var voucherFetcher: KredivoVoucherFetcherMock = KredivoVoucherFetcherMock()
        voucherFetcher.mockResponse = KredivoVoucherFetcherMock.loadMock()
        
        let viewModel: KredivoTopUpPageViewModel = KredivoTopUpPageViewModel(
            mobileCreditFetcher: mobileCreditFetcher,
            voucherFetcher: voucherFetcher
        )
        viewModel.navigationDelegate = self
        
        let viewController: KredivoTopUpPageViewController = KredivoTopUpPageViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension KredivoAppCoordinator: KredivoTopUpPageNavigationDelegate {
    
    func navigateToTransactionPage(
        mobileNumber: String,
        mobileCredit: KredivoMobileCreditProduct,
        voucherFetcher: KredivoVoucherFetcherProtocol = KredivoVoucherFetcher()
    ) {
        
        let viewModel: KredivoTransactionPageViewModel = KredivoTransactionPageViewModel(
            mobileNumber: mobileNumber,
            mobileCredit: mobileCredit,
            voucherFetcher: voucherFetcher
        )
        viewModel.navigationDelegate = self
        
        let viewController: KredivoTransactionPageViewController = KredivoTransactionPageViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToVoucherDetail(voucher: KredivoVoucherItem) {
        // TODO: Voucher detail
    }
}

extension KredivoAppCoordinator: KredivoTransactionPageNavigationDelegate {
    
     func navigateToStatusPage() {
         // TODO: Status page
     }
     
     func navigateToVoucherPage() {
         // TODO: Voucher page
     }
}
