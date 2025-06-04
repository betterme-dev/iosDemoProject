//
//  ActiveFastingPresenter.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

import ReduxCore

struct ActiveFastingPresenter {
    private typealias Props = ActiveFastingViewController.Props
    
    let render: CommandWith<ActiveFastingViewController.Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command
    
    func present(state: AppState) {
        render.perform(
            with: Props(
                onDestroy: endObserving
            )
        )
    }
}
