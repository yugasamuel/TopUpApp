//
//  KredivoPromoBannerViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoPromoBannerViewModelDelegate: AnyObject {
    func didSelectVoucher(_ voucher: KredivoVoucherItem)
}

final class KredivoPromoBannerViewModel: ObservableObject {
    
    weak var delegate: KredivoPromoBannerViewModelDelegate?
    
    @Published private(set) var vouchers: [KredivoVoucherItem] = []
    
    private let voucherFetcher: KredivoVoucherFetcherProtocol
    
    init(voucherFetcher: KredivoVoucherFetcherProtocol = KredivoVoucherFetcher()) {
        self.voucherFetcher = voucherFetcher
        
        // TODO: Remove mock
        self.vouchers = [
            KredivoVoucherItem(
                name: "VOUCHERPROMO1",
                number: 4,
                percentage: 10,
                iterator: 0,
                imageURL: "https://placehold.co/1000x400/239CEC/FFFFFF/png",
                minTransactionAmount: 50000,
                endDate: "1682787599",
                id: 4111,
                termsAndCondition: "Syarat & Ketentuan berlaku",
                howToUse: "Gunakan saat checkout",
                usageCount: 2,
                startDate: "1680282000",
                maxDiscount: 20000,
                voucherCode: "ACBDED88"
            ),
            KredivoVoucherItem(
                name: "VOUCHERPROMO2",
                number: 3,
                percentage: 15,
                iterator: 1,
                imageURL: "https://placehold.co/1000x400/E91E63/FFFFFF/png",
                minTransactionAmount: 100000,
                endDate: "1682787600",
                id: 4112,
                termsAndCondition: "Berlaku untuk semua produk",
                howToUse: "Masukkan kode saat pembayaran",
                usageCount: 1,
                startDate: "1680282100",
                maxDiscount: 25000,
                voucherCode: "XYZ12345"
            ),
            KredivoVoucherItem(
                name: "VOUCHERPROMO3",
                number: 2,
                percentage: 20,
                iterator: 2,
                imageURL: "https://placehold.co/1000x400/4CAF50/FFFFFF/png",
                minTransactionAmount: 75000,
                endDate: "1682787700",
                id: 4113,
                termsAndCondition: "Hanya berlaku di aplikasi",
                howToUse: "Klik 'Gunakan Voucher'",
                usageCount: 3,
                startDate: "1680282200",
                maxDiscount: 30000,
                voucherCode: "PROMO2023"
            ),
            KredivoVoucherItem(
                name: "VOUCHERPROMO4",
                number: 1,
                percentage: 5,
                iterator: 3,
                imageURL: "https://placehold.co/1000x400/FF9800/FFFFFF/png",
                minTransactionAmount: 20000,
                endDate: "1682787800",
                id: 4114,
                termsAndCondition: "Berlaku untuk pembelian pertama",
                howToUse: "Voucher otomatis terpakai",
                usageCount: 0,
                startDate: "1680282300",
                maxDiscount: 10000,
                voucherCode: "FIRSTBUY"
            )
        ]
    }
    
    func setVouchers(_ vouchers: [KredivoVoucherItem]) {
        self.vouchers = vouchers
    }
    
    func didSelectVoucher(_ voucher: KredivoVoucherItem) {
        delegate?.didSelectVoucher(voucher)
    }
}
