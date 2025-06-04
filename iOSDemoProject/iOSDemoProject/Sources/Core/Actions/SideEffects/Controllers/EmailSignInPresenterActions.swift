//
//  EmailSignInPresenterActions.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import ReduxCore
import Foundation

extension Actions {
    enum EmailSignInPresenter {
        struct Succeeded: Action {
            let authTokenInfo: AuthTokenInfo
            let emailAccount: EmailAccount
            let userProperties: UserProperties
        }
        
        struct Failed: Action {
            let error: EmailAuthError
        }
        
        struct SignOutSuccess: Action {}
    }
}
