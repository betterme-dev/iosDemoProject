//
//  EmailAuthInputState.swift
//  Betterme
//
//  Created by Serhii Onopriienko on 24.02.2020.
//  Copyright © 2020 BetterMe. All rights reserved.
//

import ReduxCore
import Foundation

public struct EmailAuthInputState: Equatable {
    public var email: String
    public var password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    public static let initial = EmailAuthInputState(email: "", password: "")
}

func reduce(_ state: EmailAuthInputState?, with action: Action) -> EmailAuthInputState? {
    let nonOptionalState = state ?? .initial
    switch action {
    case let action as Actions.LoginPresenter.EmailDidChange:
        return nonOptionalState | { $0.email = action.email }
         
    case let action as Actions.LoginPresenter.PasswordDidChange:
        return nonOptionalState | { $0.password = action.password }
         
    default:
        return state
    }
}
