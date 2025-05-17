//
//  KredivoMerchantDetails.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoMerchantDetails: Decodable {
    let logoURL: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case logoURL = "logo_url"
        case name
    }
}
