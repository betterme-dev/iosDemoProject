//
//  NavigationMiddleware.swift
//  BetterMen
//
//  Created by Vadym Mitin on 16.02.2023.
//  Copyright © 2023 Genesis Media. All rights reserved.
//

import ReduxCore
import Foundation


final class NavigationMiddleware {
    func middleware() -> Middleware<AppState> {
        { (dispatch: @escaping Dispatch, action: Action, oldState: AppState, newState: AppState) in
            switch action {
            case is Actions.Application.DidFinishLaunch:
                switch newState.auth {
                case .idle:
                    dispatch(Actions.NavigationMiddleware.ShowLogin())
                case .email:
                    dispatch(Actions.NavigationMiddleware.ShowMain())
                }
                
            case is Actions.EmailSignInPresenter.Succeeded:
                dispatch(Actions.NavigationMiddleware.ShowMain())
                
            case is Actions.EmailSignInPresenter.SignOutSuccess:
                dispatch(Actions.NavigationMiddleware.ShowLogin())
                
            default:
                break
            }
        }
    }
}
