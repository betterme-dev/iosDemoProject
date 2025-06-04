//
//  StoreLocator.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation
import ReduxCore

final class StoreLocator {
    private static var store: Store<AppState>?
    
    static func populate(with store: Store<AppState>) {
        self.store = store
    }
    
    static var shared: Store<AppState> {
        guard let store = store else {
            fatalError("Store is not populated into locator")
        }
        
        return store
    }
}
