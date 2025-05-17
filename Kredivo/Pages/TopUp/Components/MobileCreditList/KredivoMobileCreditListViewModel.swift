//
//  KredivoMobileCreditListViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoMobileCreditListViewModelDelegate: AnyObject {
    func onTapProduct(_ product: KredivoMobileCreditProduct)
    func onTapTryAgain()
}

enum KredivoMobileCreditListViewModelState {
    case invalidOperator
    case loading
    case loaded([KredivoMobileCreditProduct])
    case error(KredivoNetworkError)
}

final class KredivoMobileCreditListViewModel: ObservableObject {
    
    weak var delegate: KredivoMobileCreditListViewModelDelegate?
    
    @Published private(set) var products: [KredivoMobileCreditProduct] = []
    @Published private(set) var state: KredivoMobileCreditListViewModelState = .invalidOperator
    
    init() { }
    
    func setState(_ state: KredivoMobileCreditListViewModelState) {
        self.state = state
    }
    
    func onTapProduct(_ product: KredivoMobileCreditProduct) {
        delegate?.onTapProduct(product)
    }
    
    func onTapTryAgain() {
        delegate?.onTapTryAgain()
    }
}
