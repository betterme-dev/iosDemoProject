//
//  FastingDetailsPresenter.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 13.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation
import ReduxCore

struct FastingDetailsPresenter {
    private typealias Props = FastingDetailsViewController.Props
    
    let render: CommandWith<FastingDetailsViewController.Props>
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
