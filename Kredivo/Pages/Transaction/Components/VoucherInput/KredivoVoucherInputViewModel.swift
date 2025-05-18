//
//  KredivoVoucherInputViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import Foundation

enum KredivoVoucherInputViewModelState {
    case empty
    case filled(KredivoVoucherItem)
}

final class KredivoVoucherInputViewModel: ObservableObject {
    
    @Published private(set) var state: KredivoVoucherInputViewModelState = .empty
    
    init() { }
    
    func setVoucherState(_ state: KredivoVoucherInputViewModelState) {
        self.state = state
    }
}
