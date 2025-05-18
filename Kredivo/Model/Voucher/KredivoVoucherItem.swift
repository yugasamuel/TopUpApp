//
//  KredivoVoucherItem.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoVoucherItem: Decodable, Identifiable {
    let name: String
    let number: Int
    let percentage: Int
    let iterator: Int
    let imageURL: String
    let minTransactionAmount: Int
    let endDate: String
    let id: Int
    let termsAndCondition: String
    let howToUse: String
    let usageCount: Int
    let startDate: String
    let maxDiscount: Int?
    let voucherCode: String
    
    enum CodingKeys: String, CodingKey {
        case name, number, percentage, iterator
        case imageURL = "image_url"
        case minTransactionAmount = "min_transaction_amount"
        case endDate = "end_date"
        case id
        case termsAndCondition = "terms_and_condition"
        case howToUse = "how_to_use"
        case usageCount = "usage_count"
        case startDate = "start_date"
        case maxDiscount = "max_discount"
        case voucherCode = "voucher_code"
    }
    
    var formattedStartDate: String? {
        formatUnixTimestamp(startDate)
    }
    
    var formattedEndDate: String? {
        formatUnixTimestamp(endDate)
    }
    
    private func formatUnixTimestamp(_ timestampString: String) -> String? {
        guard let timestamp: Double = Double(timestampString) else {
            print("Invalid timestamp string.")
            return nil
        }
        
        let date: Date = Date(timeIntervalSince1970: timestamp)
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: date)
    }
}
