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

// MARK: - KredivoTopUpPageNavigationDelegate & KredivoVoucherListPageNavigationDelegate

extension KredivoAppCoordinator: KredivoTopUpPageNavigationDelegate, KredivoVoucherListPageNavigationDelegate {
    
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
    
    func navigateToVoucherDetail(_ voucher: KredivoVoucherItem) {
        // TODO: Voucher detail
    }
    
    func backToPreviousPage() {
        navigationController.popViewController(animated: true)
    }
    
    func navigateToStatusPage(
        mobileNumber: String,
        mobileCreditProductCode: String,
        mobileCreditLabel: String,
        voucherId: Int?
    ) {
        
    }
}

// MARK: - KredivoTransactionPageNavigationDelegate

extension KredivoAppCoordinator: KredivoTransactionPageNavigationDelegate {
    
    func navigateToStatusPage() {
        // TODO: Status page
    }
    
    func navigateToVoucherPage(
        voucherFetcher: KredivoVoucherFetcherProtocol,
        delegate: KredivoVoucherListPageViewModelDelegate?
    ) {
        let viewModel: KredivoVoucherListPageViewModel = KredivoVoucherListPageViewModel(
            voucherFetcher: voucherFetcher
        )
        viewModel.navigationDelegate = self
        viewModel.delegate = delegate
        
        let viewController: KredivoVoucherListPageViewController = KredivoVoucherListPageViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
