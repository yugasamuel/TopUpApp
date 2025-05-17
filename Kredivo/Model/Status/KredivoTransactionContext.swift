//
//  KredivoTransactionContext.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

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
}
