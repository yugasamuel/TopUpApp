//
//  KredivoTransactionDetailsViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import Foundation

final class KredivoTransactionDetailsViewModel: ObservableObject {
    
    let mobileCredit: KredivoMobileCreditProduct
    @Published private(set) var voucher: KredivoVoucherItem?
    
    var finalFormattedPrice: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currencyCode
        let discountedPrice: Double = mobileCredit.price - (mobileCredit.price * Double(voucher?.percentage ?? 0) / 100)
        return formatter.string(from: NSNumber(value: discountedPrice)) ?? String(mobileCredit.price)
    }
    
    var formattedDiscountPrice: String? {
        if let discountPercentage: Int = voucher?.percentage {
            let formatter: NumberFormatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = Locale.current.currencyCode
            let discountedPrice: Double = mobileCredit.price * Double(discountPercentage) / 100
            return formatter.string(from: NSNumber(value: discountedPrice))
        }
        else {
            return nil
        }
    }
    
    init(mobileCredit: KredivoMobileCreditProduct, voucher: KredivoVoucherItem? = nil) {
        self.mobileCredit = mobileCredit
        self.voucher = voucher
    }
    
    func setVoucher(_ voucher: KredivoVoucherItem?) {
        self.voucher = voucher
    }
}
