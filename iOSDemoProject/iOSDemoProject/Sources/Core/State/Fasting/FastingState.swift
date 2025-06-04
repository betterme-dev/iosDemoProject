//
//  FastingState.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 09.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation
import ReduxCore

struct FastingState: Equatable {
    enum Contentstate: Equatable {
        case idle
        case loading
        case loaded([Fasting])
    }
    
    var content: Contentstate
    
    static let initial = FastingState(content: .idle)
}

func reduce(_ state: FastingState, with action: Action) -> FastingState {
    switch action {
    case is Actions.ListPresenter.Appeared:
        switch state.content {
        case .idle:
            return state | {
                $0.content = .loading
            }
        case .loading, .loaded:
            return state
        }
        
    case let action as Actions.FastingLoadingPresenter.Loaded:
        return state | {
            $0.content = .loaded(action.fastings)
        }
        
    default:
        return state
    }
}
