//
//  ChainCoordinator.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import ReduxCore
import UIKit

protocol ChainCoordinator {
    var rootViewController: UIViewController { get }
    
    var next: ChainCoordinator? { get set }
    
    /// Method where actions should be handled.
    ///  - Parameters:
    ///     - state: The instance of a state. Usually, it is the current state.
    ///     - action: An abstract action.
    /// - returns: `true` if action is handled.
    func handle(state: AppState, action: Action) -> Bool
}

extension ChainCoordinator {
    func handle(state: AppState, action: Action) {
        let _: Bool = handle(state: state, action: action)
    }
}
