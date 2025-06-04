//
//  RestoreInitialState.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

func restoreState() -> AppState {
    return AppState(
        auth: restore() ?? .initial,
        user: restore() ?? .initial,
        emailAuthInput: nil,
        fasting: .initial
    )
}

private func restore<T: Codable>(
    key: String = String(reflecting: T.self)
) -> T? {
    do {
        return try CodableStorage().fetch() as T
    } catch {
        debugPrint("🛑 failed to restore \(T.self) - \(error) for key: \(key)")
        return nil
    }
}
