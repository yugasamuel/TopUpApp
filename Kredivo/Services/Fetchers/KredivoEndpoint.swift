//
//  KredivoEndpoint.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

enum KredivoEndpoint {
    
    static private let baseURLString: String = "https://api.kredivo.com"
    
    case mobileCredit
    case voucher
    case status
    
    var url: URL? {
        switch self {
        case .mobileCredit:
            return URL(string: "\(Self.baseURLString)/v1/mobile-credit")
        case .voucher:
            return URL(string: "\(Self.baseURLString)/v1/voucher")
        case .status:
            return URL(string: "\(Self.baseURLString)/v1/status")
        }
    }
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
