//
//  MainCoordinatorActions.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import ReduxCore
import Foundation

extension Actions {
    enum MainCoordinator {
        struct ShowList: Action {}
        
        struct ShowFasting: Action {}
        
        struct ShowProfile: Action {}
    }
}
