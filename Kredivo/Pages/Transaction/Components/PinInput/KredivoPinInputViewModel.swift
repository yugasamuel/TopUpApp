//
//  KredivoPinInputViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import Foundation

final class KredivoPinInputViewModel: ObservableObject {
    
    @Published var pin: String = ""
    @Published var isPinVisible: Bool = false
    
    var isPinValid: Bool {
        !pin.isEmpty
    }
    
    init() { }
}
