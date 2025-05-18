//
//  KredivoFetchersProtocol.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoMobileCreditFetcherProtocol {
    func fetch(mobileNumber: String) async throws -> KredivoMobileCreditResponse
}

protocol KredivoVoucherFetcherProtocol {
    func fetch() async throws -> KredivoVoucherResponse
}

protocol KredivoStatusFetcherProtocol {
    func fetch(
        mobileNumber: String,
        mobileCreditProductCode: String,
        mobileCreditLabel: String,
        voucherId: Int?
    ) async throws -> KredivoStatusResponse
}
