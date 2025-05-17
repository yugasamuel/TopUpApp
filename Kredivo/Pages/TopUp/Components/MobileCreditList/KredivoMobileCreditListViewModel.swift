//
//  KredivoMobileCreditListViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

enum KredivoMobileCreditListViewModelState {
    case invalidMobileNumber
    case loading
    case loaded([KredivoMobileCreditProduct])
    case error(KredivoNetworkError)
}

final class KredivoMobileCreditListViewModel: ObservableObject {
    
    @Published private(set) var products: [KredivoMobileCreditProduct] = []
    @Published private(set) var state: KredivoMobileCreditListViewModelState = .invalidMobileNumber
    
    init() { }
    
    func setState(_ state: KredivoMobileCreditListViewModelState) {
        self.state = state
    }
}
