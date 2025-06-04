//
//  StoreBackupPresenter.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import ReduxCore

import Foundation

struct StoreBackupPresenter {
    let render: CommandWith<StoreBackupController.Props>
    let endObserving: Command
    
    func present(state: AppState) {
        render.perform(
            with: StoreBackupController.Props(
                auth: state.auth,
                user: state.user,
                onDestroy: endObserving
            )
        )
    }
}
