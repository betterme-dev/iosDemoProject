//
//  StoreBackupController.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation
import ReduxCore


final class StoreBackupController {
    struct Props: Equatable {
        let auth: AuthState
        let user: UserState
        
        let onDestroy: Command
    }
    
    private var props: StoreBackupController.Props?
    
    private let authStorage = CodableStorage<AuthState>()
    private let userStorage = CodableStorage<UserState>()
    
    func render(props: StoreBackupController.Props) {
        guard self.props != props else { return }
        
        storeDefaults(storage: authStorage, newValue: props.auth)
        storeDefaults(storage: userStorage, newValue: props.user)
    }
    
    private func storeDefaults<T: Codable>(storage: CodableStorage<T>, newValue: T?) {
        do {
            if let value = newValue {
                try storage.store(value)
            } else {
                try storage.clear()
            }
        } catch CodableStorageError.emptyData {
        } catch {
            debugPrint("CodableStorage \(error)")
        }
    }
}
