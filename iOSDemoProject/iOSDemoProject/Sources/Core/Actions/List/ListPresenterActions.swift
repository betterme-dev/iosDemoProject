//
//  ListPresenterActions.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 09.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import ReduxCore
import Foundation

extension Actions {
    enum ListPresenter {
        struct Appeared: Action {}
        
        struct ShowFasting: Action {
            let id: String
        }
    }
}
