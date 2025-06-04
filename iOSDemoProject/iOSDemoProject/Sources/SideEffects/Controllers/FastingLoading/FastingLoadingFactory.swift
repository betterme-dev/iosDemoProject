//
//  FastingLoadingFactory.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 09.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit

import ReduxCore

struct FastingLoadingFactory {
    private let store: Store<AppState>
    private let requestManager: RequestManager
    
    init(
        requestManager: RequestManager = RequestManagerLocator.shared,
        store: Store<AppState> = StoreLocator.shared
    ) {
        self.requestManager = requestManager
        self.store = store
    }
    
    func `default`() -> FastingLoadingController {
        let controller = FastingLoadingController(requestManager: requestManager)
        var cancelObserving: Cancellation?
        let presenter = FastingLoadingPresenter(
            render: CommandWith { [weak controller] props in
                controller?.render(props: props)
            }.dispatched(on: DispatchQueue(label: "EmailSignInController queue")),
            dispatch: CommandWith { [weak store] action in
                store?.dispatch(action: action)
            },
            endObserving: Command(id: "endObserving") { cancelObserving?.cancel() }
        )
        
        cancelObserving = store.observe(with: presenter.present)

        return controller
    }
}
