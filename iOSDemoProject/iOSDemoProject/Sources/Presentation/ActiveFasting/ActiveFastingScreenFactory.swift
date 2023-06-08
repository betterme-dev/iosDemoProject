//
//  ActiveFastingScreenFactory.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit
import BMCommand
import ReduxCore

struct ActiveFastingScreenFactory {
    private let store: Store<AppState>
    
    init(store: Store<AppState> = StoreLocator.shared) {
        self.store = store
    }
    
    func `default`() -> ActiveFastingViewController {
        let controller = ActiveFastingViewController()
        var cancelObserving: Cancellation?
        let presenter = ActiveFastingPresenter(
            render: CommandWith { [weak controller] props in
                controller?.render(props: props)
            }.dispatchedOnMain(),
            dispatch: CommandWith { [weak store] action in
                store?.dispatch(action: action)
            },
            endObserving: Command(id: "endObserving") { cancelObserving?.cancel() }
        )

        controller.addWillAppearObserver { [weak store] in
            if cancelObserving == nil {
                cancelObserving = store?.observe(with: presenter.present)
            }
        }
        
        controller.addDidDisappearObserver {
            cancelObserving?.cancel()
            cancelObserving = nil
        }

        return controller
    }
}
