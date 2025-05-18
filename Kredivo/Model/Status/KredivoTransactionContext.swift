//
//  KredivoTransactionContext.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation
import UIKit

struct KredivoTransactionContext: Decodable {
    let transactionStatus: Int
    let merchantDetails: KredivoMerchantDetails
    let appliedPaymentType: String
    let checkoutAmount: String
    let orderId: String
    let itemList: [KredivoTransactionItem]
    let expirationTime: String
    let amount: String
    let transactionToken: String
    
    enum CodingKeys: String, CodingKey {
        case transactionStatus = "transaction_status"
        case merchantDetails = "merchant_details"
        case appliedPaymentType = "applied_payment_type"
        case checkoutAmount = "checkout_amount"
        case orderId = "order_id"
        case itemList = "item_list"
        case expirationTime = "expiration_time"
        case amount
        case transactionToken = "transaction_token"
    }
    
    var transactionStatusDescription: String {
        switch transactionStatus {
        case 1:
            return "Transaksi Tidak Ditemukan"
        case 2:
            return "Transaksi Pending"
        case 3:
            return "Transaksi Gagal"
        case 4:
            return "Transaksi Berhasil"
        default:
            return "Transaksi Tidak Ditemukan"
        }
    }
    
    var transactionStatusColor: UIColor {
        switch transactionStatus {
        case 1:
            return .kredivoGray
        case 2:
            return .kredivoBlue
        case 3:
            return .red
        case 4:
            return .kredivoGreen
        default:
            return .kredivoGray
        }
    }
    
    var formattedAppliedPaymentType: String {
        if appliedPaymentType.contains("days") {
            return "Bayar dalam " + appliedPaymentType.replacingOccurrences(of: "_days", with: " hari")
        }
        else if appliedPaymentType.contains("months") {
            return "Bayar dalam " + appliedPaymentType.replacingOccurrences(of: "_months", with: " bulan")
        }
        else {
            return "Bayar dalam 30 hari"
        }
    }
}
