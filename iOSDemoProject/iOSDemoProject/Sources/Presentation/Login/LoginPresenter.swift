//
//  LoginPresenter.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 06.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

import ReduxCore

struct LoginPresenter {
    private typealias Props = LoginViewController.Props
    
    let render: CommandWith<LoginViewController.Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command
    
    func present(state: AppState) {
        render.perform(
            with: Props(
                onEmailChanged: CommandWith(id: "onEmailChanged") { email in
                    dispatch.perform(with: Actions.LoginPresenter.EmailDidChange(email: email))
                },
                onPasswordChanged: CommandWith(id: "onPasswordChanged") { password in
                    dispatch.perform(with: Actions.LoginPresenter.PasswordDidChange(password: password))
                },
                signInButton: signInButtonState(with: state.emailAuthInput),
                onDestroy: endObserving
            )
        )
    }
    
    private func signInButtonState(with state: EmailAuthInputState?) -> LoginViewController.Props.SignInButtonState {
        guard let email = state?.email, let password = state?.password else { return .disabled }
        
        if CredentialsValidator.isValid(email: email), CredentialsValidator.isValid(password: password) {
            return .enabled(dispatch.bind(to: Actions.LoginPresenter.SignIn(email: email, password: password), id: "onContinue \(email)\(password)"))
        } else {
            return .disabled
        }
    }
}
