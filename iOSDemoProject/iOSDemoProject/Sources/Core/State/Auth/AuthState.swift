//
//  AuthState.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation
import ReduxCore

enum AuthState: Equatable, Codable {
    case idle
    case email(AuthState.Email)
    
    struct EmailCredentials: Equatable, Codable {
        let email: String
        let password: String
    }
    
    struct EmailAuthorized: Equatable, Codable {
        let account: EmailAccount
        var remoteData: AuthTokenInfo
    }
    
    enum Email: Equatable, Codable {
        case signingIn(AuthState.EmailCredentials)
        case authorized(AuthState.EmailAuthorized)
        case signingInFailed(EmailAuthError)
        case loggingOut(AuthState.EmailAuthorized)
    }
    
    static let initial = AuthState.idle
}

func reduce(_ state: AuthState, with action: Action) -> AuthState {
    switch action {
    case let action as Actions.LoginPresenter.SignIn:
        return .email(
            .signingIn(
                AuthState.EmailCredentials(
                    email: action.email,
                    password: action.password
                )
            )
        )
        
    case let action as Actions.EmailSignInPresenter.Succeeded:
        return .email(
            .authorized(
                AuthState.EmailAuthorized(
                    account: action.emailAccount,
                    remoteData: action.authTokenInfo
                )
            )
        )
        
    case is Actions.ProfilePresenter.SignOut:
        guard case .email(.authorized(let credentials)) = state
        else { return state }
        
        return .email(
            .loggingOut(credentials)
        )
        
    case is Actions.EmailSignInPresenter.SignOutSuccess:
        return .idle
        
    default:
        return state
    }
}
