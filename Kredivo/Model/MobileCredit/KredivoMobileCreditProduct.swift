//
//  KredivoMobileCreditProduct.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoMobileCreditProduct: Decodable {
    let productCode: String
    let billType: String
    let label: String
    let `operator`: String
    let nominal: String
    let description: String
    let sequence: Int?
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case productCode = "product_code"
        case billType = "bill_type"
        case label
        case `operator`
        case nominal
        case description
        case sequence
        case price
    }
}
