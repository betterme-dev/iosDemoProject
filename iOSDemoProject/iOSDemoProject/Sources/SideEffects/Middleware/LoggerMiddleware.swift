//
//  LoggerMiddleware.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 13.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import ReduxCore
import Foundation
import os.log

final class LoggerMiddleware {
    func middleware() -> Middleware<AppState> {
        { (_, action: Action, _, newState: AppState) in
            #if DEBUG
            os_log(
                "%@",
                log: OSLog(subsystem: Bundle.main.bundleIdentifier ?? "", category: ""),
                type: .debug,
                "✳️ \(String(reflecting: action).prefix(500))"
            )
            #endif
        }
    }
}
