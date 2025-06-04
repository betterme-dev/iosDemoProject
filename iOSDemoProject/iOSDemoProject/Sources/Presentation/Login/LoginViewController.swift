//
//  LoginViewController.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 06.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit

import SnapKit
#if DEBUG
import SwiftUI
#endif

final class LoginViewController: UIViewController {
    struct Props: Equatable {
        let onEmailChanged: CommandWith<String>
        let onPasswordChanged: CommandWith<String>
        let signInButton: SignInButtonState
        let onDestroy: Command
        
        enum SignInButtonState: Equatable {
            case enabled(Command)
            case disabled
        }
        
        static let initial = Props(
            onEmailChanged: .nop,
            onPasswordChanged: .nop,
            signInButton: .disabled,
            onDestroy: .nop
        )
    }
    
    private var willAppearObservers: [() -> Void] = []
    private var didDisappearObservers: [() -> Void] = []
    private var props = Props.initial
    
    private let titleLabel = UILabel()
    private let emailContainerView = UIView()
    private let emailTextField = UITextField()
    private let separatorView = UIView()
    private let passwordContainerView = UIView()
    private let passwordTextField = UITextField()
    private let signInButton = UIButton(type: .system)
    
    deinit {
        props.onDestroy.perform()
    }
    
    func render(props: Props) {
        guard self.props != props else { return }
        self.props = props
        view.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppearObservers.forEach { $0() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappearObservers.forEach { $0() }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        switch props.signInButton {
        case .enabled:
            signInButton.isUserInteractionEnabled = true
            signInButton.backgroundColor = UIColor(hexString: "#007AFF")
        case .disabled:
            signInButton.isUserInteractionEnabled = false
            signInButton.backgroundColor = UIColor(hexString: "#979592")
        }
    }

    func addWillAppearObserver(_ block: @escaping () -> Void) {
        willAppearObservers.append(block)
    }

    func addDidDisappearObserver(_ block: @escaping () -> Void) {
        didDisappearObservers.append(block)
    }
}

// MARK: - Private methods
private extension LoginViewController {
    func configureUI() {
        view.backgroundColor = UIColor(hexString: "#F2F2F7")
        
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "Login"
        
        emailContainerView.backgroundColor = .white
        emailContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        emailContainerView.layer.cornerRadius = 12
        
        emailTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        emailTextField.textColor = .black
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholder = "Email"
        emailTextField.addTarget(self, action: #selector(emailDidChangeAction), for: .editingChanged)
        
        passwordContainerView.backgroundColor = .white
        passwordContainerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordContainerView.layer.cornerRadius = 12
        
        passwordTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        passwordTextField.textColor = .black
        passwordTextField.textContentType = .password
        passwordTextField.textAlignment = .natural
        passwordTextField.returnKeyType = .continue
        passwordTextField.spellCheckingType = .no
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        passwordTextField.addTarget(self, action: #selector(passwordDidChangeAction), for: .editingChanged)
        
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        signInButton.backgroundColor = UIColor(hexString: "#007AFF")
        signInButton.tintColor = .white
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(onSigninTap), for: .touchUpInside)
    }
    
    func configureLayout() {
        separatorView.backgroundColor = UIColor(hexString: "#E4E4E6")
        
        emailContainerView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        [
            titleLabel,
            emailContainerView,
            passwordContainerView,
            signInButton,
        ].forEach(view.addSubview)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emailContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(emailContainerView.snp.bottom)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom).offset(32)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emailContainerView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        passwordContainerView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func emailDidChangeAction(_ sender: UITextField) {
        let emailString = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        props.onEmailChanged.perform(with: emailString)
    }
    
    @objc func passwordDidChangeAction(_ sender: UITextField) {
        props.onPasswordChanged.perform(with: sender.text ?? "")
    }
    
    @objc func onSigninTap() {
        switch props.signInButton {
        case .enabled(let onTap):
            onTap.perform()
        case .disabled:
            break
        }
    }
}

#if DEBUG
struct LoginViewController_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PreviewDeviceModifier.defaultDevices()) {
                UIViewControllerPreview {
                    let vc = LoginViewController()
                    vc.render(
                        props: LoginViewController.Props(
                            onEmailChanged: .nop,
                            onPasswordChanged: .nop,
                            signInButton: .disabled,
                            onDestroy: .nop
                        )
                    )
                    return vc
                }.modifier($0)
            }
        }
    }
}
#endif
