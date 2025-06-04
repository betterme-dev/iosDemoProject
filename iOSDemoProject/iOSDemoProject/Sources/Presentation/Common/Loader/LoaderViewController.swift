//
//  LoaderViewController.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit

final class LoaderViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureUI()
        
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

private extension LoaderViewController {
    private func configureUI() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
        
        activityIndicator.backgroundColor = UIColor(hexString: "#F2F2F2").withAlphaComponent(0.8)
        activityIndicator.color = UIColor(hexString: "#595F67")
        activityIndicator.layer.cornerRadius = 12
    }
    
    private func configureLayout() {
        [
            activityIndicator
        ].forEach(view.addSubview)
        
        activityIndicator.snp.makeConstraints { make in
            make.size.equalTo(56)
            make.center.equalToSuperview()
        }
    }
}
