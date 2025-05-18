//
//  KredivoTransactionItem.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoTransactionItem: Decodable, Identifiable {
    var id: String { "\(String(pId ?? 0))-\(name)-\(sku)" }
    let aggregatedPrice: String?
    let quantity: Int
    let status: String?
    let unitPrice: String?
    let totalAmount: String
    let pId: Int?
    let skuType: Int
    let name: String
    let category: String?
    let sku: String
    
    enum CodingKeys: String, CodingKey {
        case aggregatedPrice = "aggregated_price"
        case quantity
        case status
        case unitPrice = "unit_price"
        case totalAmount = "total_amount"
        case pId = "p_id"
        case skuType = "sku_type"
        case name
        case category
        case sku
    }
}
