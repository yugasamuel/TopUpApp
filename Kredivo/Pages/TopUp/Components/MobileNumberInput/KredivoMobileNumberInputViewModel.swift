//
//  KredivoMobileNumberInputViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

final class KredivoMobileNumberInputViewModel: ObservableObject {
    
    @Published var mobileNumber: String = ""
    @Published var isValidMobileNumber: Bool = false
    
    init() { }
    
    func onChangeMobileNumber(_ mobileNumber: String) {
        isValidMobileNumber = mobileNumber.count >= 4
    }
}
