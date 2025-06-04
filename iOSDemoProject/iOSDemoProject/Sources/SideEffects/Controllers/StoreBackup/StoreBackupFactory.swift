//
//  StoreBackupFactory.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

import ReduxCore

struct StoreBackupFactory {
    private let store: Store<AppState>
    
    init(store: Store<AppState> = StoreLocator.shared) {
        self.store = store
    }
    
    func `default`() -> StoreBackupController {
        let controller = StoreBackupController()
        var cancelObserving: Cancellation?
        let presenter = StoreBackupPresenter(
            render: CommandWith { [weak controller] props in
                controller?.render(props: props)
            }.dispatched(on: DispatchQueue(label: "StoreBackupController queue")),
            endObserving: Command(id: "endObserving") { cancelObserving?.cancel() }
        )
        
        cancelObserving = store.observe(with: presenter.present)

        return controller
    }
}
