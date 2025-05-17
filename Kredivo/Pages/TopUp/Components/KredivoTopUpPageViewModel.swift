//
//  KredivoTopUpViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

final class KredivoTopUpPageViewModel: ObservableObject {
    
    @Published var tabSelection: Int = 0
    
    let mobileNumberInputViewModel: KredivoMobileNumberInputViewModel = KredivoMobileNumberInputViewModel()
    let mobileCreditListViewModel: KredivoMobileCreditListViewModel = KredivoMobileCreditListViewModel()
    let promoBannerViewModel: KredivoPromoBannerViewModel = KredivoPromoBannerViewModel()
    let dataPackageViewModel: KredivoDataPackageViewModel = KredivoDataPackageViewModel()
    
    private let mobileCreditFetcher: KredivoMobileCreditFetcherProtocol
    
    init(mobileCreditFetcher: KredivoMobileCreditFetcherProtocol = KredivoMobileCreditFetcher()) {
        self.mobileCreditFetcher = mobileCreditFetcher
        
        mobileNumberInputViewModel.delegate = self
        mobileCreditListViewModel.delegate = self
        promoBannerViewModel.delegate = self
    }
    
    @MainActor
    func fetchMobileCredits() async {
        mobileCreditListViewModel.setState(.loading)
        
        do {
//            let response: KredivoMobileCreditResponse = try await mobileCreditFetcher.fetch(
//                mobileNumber: mobileNumberInputViewModel.mobileNumber)
            // mobileCreditListViewModel.setState(.loaded(response.products))
            
            // TODO: Remove mock
            mobileCreditListViewModel.setState(
                .loaded(
                    [
                        KredivoMobileCreditProduct(
                            productCode: "PULSA10",
                            billType: "pulsa",
                            label: "Pulsa 10K",
                            operator: "Telkomsel",
                            nominal: "10000",
                            description: "Pulsa senilai 10.000",
                            sequence: 1,
                            price: 10500
                        ),
                        KredivoMobileCreditProduct(
                            productCode: "PULSA20",
                            billType: "pulsa",
                            label: "Pulsa 20K",
                            operator: "Indosat",
                            nominal: "20000",
                            description: "Pulsa senilai 20.000",
                            sequence: 2,
                            price: 20500
                        ),
                        KredivoMobileCreditProduct(
                            productCode: "PULSA50",
                            billType: "pulsa",
                            label: "Pulsa 50K",
                            operator: "XL",
                            nominal: "50000",
                            description: "Pulsa senilai 50.000",
                            sequence: 3,
                            price: 50500
                        ),
                        KredivoMobileCreditProduct(
                            productCode: "DATA10GB",
                            billType: "data",
                            label: "Data 10GB",
                            operator: "Telkomsel",
                            nominal: "50000",
                            description: "Paket data 10GB, masa aktif 30 hari",
                            sequence: 4,
                            price: 60000
                        ),
                        KredivoMobileCreditProduct(
                            productCode: "DATA25GB",
                            billType: "data",
                            label: "Data 10000",
                            operator: "Indosat",
                            nominal: "25GB",
                            description: "Paket data 25GB, masa aktif 30 hari",
                            sequence: 5,
                            price: 125000
                        )
                    ]
                )
            )
        }
        catch let error as KredivoNetworkError {
            mobileCreditListViewModel.setState(.error(error))
        }
        catch {
            mobileCreditListViewModel.setState(.error(.invalidResponse))
        }
    }
}

// MARK: - KredivoMobileNumberInputViewModelDelegate

extension KredivoTopUpPageViewModel: KredivoMobileNumberInputViewModelDelegate {
    func onChangeMobileNumber(_ mobileNumber: String) {
        let isValidMobileNumber: Bool = mobileNumber.count >= 4
        mobileNumberInputViewModel.setMobileNumberValidity(isValid: isValidMobileNumber)
    }
}

// MARK: - KredivoMobileCreditListViewModelDelegate

extension KredivoTopUpPageViewModel: KredivoMobileCreditListViewModelDelegate {
    func onTapProduct(_ product: KredivoMobileCreditProduct) {
        // TODO: Navigate to product detail
    }
    
    func onTapTryAgain() {
        // TODO: Fetch again
    }
}

// MARK: - KredivoPromoBannerViewModelDelegate

extension KredivoTopUpPageViewModel: KredivoPromoBannerViewModelDelegate {
    func didSelectVoucher(_ voucher: KredivoVoucherItem) {
        // TODO: Navigate to voucher detail
    }
}
