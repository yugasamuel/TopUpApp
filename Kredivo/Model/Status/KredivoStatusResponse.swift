//
//  KredivoStatusResponse.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoStatusResponse: Decodable {
    let message: String
    let transactionContext: KredivoTransactionContext
    
    enum CodingKeys: String, CodingKey {
        case message
        case transactionContext = "transaction_context"
    }
}
