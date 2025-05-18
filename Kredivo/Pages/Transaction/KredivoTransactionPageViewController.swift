//
//  KredivoTransactionPageViewController.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI
import UIKit

final class KredivoTransactionPageViewController: UIViewController {
    
    private let viewModel: KredivoTransactionPageViewModel
    
    init(viewModel: KredivoTransactionPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Konfirmasi Pembayaran"
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

private extension KredivoTransactionPageViewController {
    func setupView() {
        let hostingController: UIHostingController = UIHostingController(
            rootView: KredivoTransactionPageView(
                viewModel: self.viewModel
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
