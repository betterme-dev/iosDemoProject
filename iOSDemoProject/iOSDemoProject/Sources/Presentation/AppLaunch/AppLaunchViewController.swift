//
//  AppLaunchViewController.swift
//  BetterMen
//
//  Created by Vadym Mitin on 25.01.2023.
//  Copyright © 2023 Genesis Media. All rights reserved.
//

import UIKit

final class AppLaunchViewController: UIViewController {
    private let spinnerImageView = UIImageView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        spinnerImageView.rotate()
    }
}

private extension AppLaunchViewController {
    private func configureUI() {
        spinnerImageView.image = UIImage(named: "welcome-loading-circle")
        
        view.backgroundColor = UIColor(hexString: "#F2F2F7")
    }
    
    private func configureLayout() {
        [
            spinnerImageView
        ].forEach(view.addSubview)
        
        spinnerImageView.snp.makeConstraints { make in
            make.size.equalTo(42)
            make.center.equalToSuperview()
        }
    }
}

private extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"

    func rotate(duration: Double = 1) {
        guard layer.animation(forKey: UIView.kRotationAnimationKey) == nil else { return }
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = Float.infinity

        layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
    }
    
    func stopRotating() {
        guard layer.animation(forKey: UIView.kRotationAnimationKey) != nil else { return }
        
        layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
    }
}
