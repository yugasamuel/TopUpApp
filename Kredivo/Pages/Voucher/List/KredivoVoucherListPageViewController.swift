//
//  KredivoVoucherListPageViewController.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI
import UIKit

final class KredivoVoucherListPageViewController: UIViewController {
    
    private let viewModel: KredivoVoucherListPageViewModel
    
    init(viewModel: KredivoVoucherListPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Voucher Saya"
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

private extension KredivoVoucherListPageViewController {
    func setupView() {
        let hostingController: UIHostingController = UIHostingController(
            rootView: KredivoVoucherListPageView(
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

