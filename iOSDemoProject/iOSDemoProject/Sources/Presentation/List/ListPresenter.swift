//
//  ListPresenter.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

import ReduxCore

struct ListPresenter {
    private typealias Props = ListViewController.Props
    
    let render: CommandWith<ListViewController.Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command
    
    func present(state: AppState) {
        render.perform(
            with: Props(
                contentState: {
                    switch state.fasting.content {
                    case .idle, .loading:
                        return .loading
                    case .loaded(let items):
                        return .loaded(
                            items.map({ fasting in
                                .init(
                                    name: fasting.name,
                                    durationHours: fasting.fastingHours + fasting.eatingHours,
                                    onClick: dispatch.bind(to: Actions.ListPresenter.ShowFasting(id: fasting.id))
                                )
                            })
                        )
                    }
                }(),
                onAppeared: dispatch.bind(to: Actions.ListPresenter.Appeared()),
                onDestroy: endObserving
            )
        )
    }
}
