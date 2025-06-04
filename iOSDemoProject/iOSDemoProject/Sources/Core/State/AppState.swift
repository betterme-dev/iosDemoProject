//
//  AppState.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation
import ReduxCore

struct AppState: Equatable {
    let auth: AuthState
    let user: UserState
    let emailAuthInput: EmailAuthInputState?
    let fasting: FastingState
    
    static let initial = AppState(
        auth: .idle,
        user: .initial,
        emailAuthInput: nil,
        fasting: .initial
    )
}

func reduce(_ state: AppState, with action: Action) -> AppState {
    AppState(
        auth: reduce(state.auth, with: action),
        user: reduce(state.user, with: action),
        emailAuthInput: reduce(state.emailAuthInput, with: action),
        fasting: reduce(state.fasting, with: action)
    )
}
