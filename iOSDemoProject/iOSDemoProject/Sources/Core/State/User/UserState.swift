//
//  UserState.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation
import ReduxCore

struct UserState: Equatable, Codable {
    var properties: UserProperties?
    
    static let initial = UserState(properties: nil)
}

func reduce(_ state: UserState, with action: Action) -> UserState {
    switch action {
    case let action as Actions.EmailSignInPresenter.Succeeded:
        return UserState(properties: action.userProperties)
    default:
        return state
    }
}
