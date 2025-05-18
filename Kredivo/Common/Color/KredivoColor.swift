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
    static let gray: UIColor = UIColor(named: "KredivoGray") ?? UIColor.systemGray
    static let orange: UIColor = UIColor(named: "KredivoOrange") ?? UIColor.systemOrange
    static let green: UIColor = UIColor(named: "KredivoGreen") ?? UIColor.systemGreen
}

extension UIColor {
    var toColor: Color {
        return Color(self)
    }
}
