//
//  KredivoEndpoint.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

enum KredivoEndpoint {
    
    static private let baseURLString: String = "https://api.kredivo.com"
    
    case mobileCredit(mobileNumber: String)
    case voucher
    case status
    
    var url: URL? {
        switch self {
        case .mobileCredit(let mobileNumber):
            var components: URLComponents? = URLComponents(string: "\(Self.baseURLString)/v1/mobile-credit")
            components?.queryItems = [URLQueryItem(
                name: "mobile_number",
                value: mobileNumber
            )]
            return components?.url
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
