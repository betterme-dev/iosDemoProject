//
//  EmailSignInFactory.swift
//  Betterme
//
//  Created by Bohdan Podvirnyi on 24.05.2022.
//  Copyright © 2022 BetterMe. All rights reserved.
//

import UIKit

import ReduxCore

struct EmailSignInFactory {
    private let store: Store<AppState>
    private let requestManager: RequestManager
    
    init(
        requestManager: RequestManager = RequestManagerLocator.shared,
        store: Store<AppState> = StoreLocator.shared
    ) {
        self.requestManager = requestManager
        self.store = store
    }
    
    func `default`() -> EmailSignInController {
        let controller = EmailSignInController(requestManager: requestManager)
        var cancelObserving: Cancellation?
        let presenter = EmailSignInPresenter(
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
