//
//  KredivoVoucherResponse.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

struct KredivoVoucherResponse: Decodable {
    let data: [KredivoVoucherItem]
}
