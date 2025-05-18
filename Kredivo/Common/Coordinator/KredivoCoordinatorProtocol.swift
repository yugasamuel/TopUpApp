//
//  KredivoCoordinatorProtocol.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import Foundation
import UIKit

protocol KredivoCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
}
