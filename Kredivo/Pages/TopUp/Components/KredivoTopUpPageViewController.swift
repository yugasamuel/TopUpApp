//
//  KredivoTopUpPageViewController.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI
import UIKit

final class KredivoTopUpPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension KredivoTopUpPageViewController {
    func setupView() {
        let hostingController: UIHostingController = UIHostingController(
            rootView: KredivoTopUpPageView(
                viewModel: KredivoTopUpPageViewModel()
            )
        )
        
        addChild(hostingController)
        
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
}
