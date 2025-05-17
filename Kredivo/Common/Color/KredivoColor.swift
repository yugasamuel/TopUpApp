//
//  KredivoColor.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation
import SwiftUI
import UIKit

struct KredivoColor {
    static let blue: UIColor = UIColor(named: "KredivoBlue") ?? UIColor.systemBlue
}

extension UIColor {
    var toColor: Color {
        return Color(self)
    }
}
