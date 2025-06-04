//
//  ProfilePresenter.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

import ReduxCore

struct ProfilePresenter {
    private typealias Props = ProfileViewController.Props
    
    let render: CommandWith<ProfileViewController.Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command
    
    func present(state: AppState) {
        guard let userProperties = state.user.properties else { return }
        
        render.perform(
            with: Props(
                avatarURL: userProperties.avatarUrl,
                fullName: userProperties.fullName,
                dateOfBirth: userProperties.dateOfBirth,
                about: userProperties.about,
                onLogOut: dispatch.bind(to: Actions.ProfilePresenter.SignOut()),
                onDestroy: endObserving
            )
        )
    }
}
