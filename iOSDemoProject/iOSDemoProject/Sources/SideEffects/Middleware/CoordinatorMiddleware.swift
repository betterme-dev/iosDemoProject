//
//  CoordinatorMiddleware.swift
//  BetterMen
//
//  Created by Vadym Mitin on 25.01.2023.
//  Copyright © 2023 Genesis Media. All rights reserved.
//

import ReduxCore
import Foundation

final class CoordinatorMiddleware {
    private let handler: (AppState, Action) -> Void
    
    init(handler: @escaping (AppState, Action) -> Void) {
        self.handler = handler
    }
    
    func middleware() -> Middleware<AppState> {
        { (_, action: Action, _, state: AppState) in
            DispatchQueue.main.async { self.handler(state, action) }
        }
    }
}
