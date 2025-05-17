//
//  KredivoMobileNumberInputViewModel.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation

protocol KredivoMobileNumberInputViewModelDelegate: AnyObject {
    func onChangeMobileNumber(_ mobileNumber: String)
}

final class KredivoMobileNumberInputViewModel: ObservableObject {
    
    weak var delegate: KredivoMobileNumberInputViewModelDelegate?
    
    @Published var mobileNumber: String = ""
    @Published var isValidMobileNumber: Bool = false
    
    init() { }
    
    func onChangeMobileNumber(_ mobileNumber: String) {
        delegate?.onChangeMobileNumber(mobileNumber)
    }
    
    func setMobileNumberValidity(isValid: Bool) {
        isValidMobileNumber = isValid
    }
}
