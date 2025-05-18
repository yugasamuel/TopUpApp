//
//  KredivoMobileCreditProduct.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoMobileCreditProduct: Decodable, Identifiable {
    var id: String { "\(productCode)-\(label)" }
    let productCode: String
    let billType: String
    let label: String
    let `operator`: String
    let nominal: String
    let description: String
    let sequence: Int?
    let price: Double
    
    var formattedNominal: String {
        guard let price: Double = Double(nominal) else { return nominal }

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        return formatter.string(from: NSNumber(value: price)) ?? nominal
    }
    
    var formattedPrice: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currencyCode
        return formatter.string(from: NSNumber(value: price)) ?? String(price)
    }
    
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
    
    func getFormattedDiscountedPrice(using discountPercentage: Int) -> String? {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currencyCode
        let discountedPrice: Double = price - (price * Double(discountPercentage / 100))
        return formatter.string(from: NSNumber(value: discountedPrice)) ?? nil
    }
}
