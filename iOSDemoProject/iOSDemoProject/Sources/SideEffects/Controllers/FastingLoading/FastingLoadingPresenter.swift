//
//  FastingLoadingPresenter.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 09.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import ReduxCore

import Foundation

struct FastingLoadingPresenter {
    let render: CommandWith<FastingLoadingController.Props>
    let dispatch: CommandWith<Action>
    let endObserving: Command
    
    func present(state: AppState) {
        render.perform(with: FastingLoadingController.Props(state: makePropsState(from: state), onDestroy: endObserving))
    }
    
    private func makePropsState(from state: AppState) -> FastingLoadingController.Props.State {
        switch state.fasting.content {
        case .idle, .loaded:
            return .idle
        case .loading:
            return loadingSatate()
        }
    }
    
    private func loadingSatate() -> FastingLoadingController.Props.State {
        return .loading(
            onSuccess: CommandWith(id: "onSuccess") { response in
                let action = Actions.FastingLoadingPresenter.Loaded(
                    fastings: response.fastings
                )
                dispatch.perform(with: action)
            },
            onFailure: CommandWith(id: "onFailure") { error in
                let emailAuthError: EmailAuthError
                switch error {
                case EmailSignInError.credentialInvalid:
                    emailAuthError = .credentialInvalid
                default:
                    emailAuthError = .general(error.localizedDescription)
                }
                let action = Actions.FastingLoadingPresenter.Failed(error: emailAuthError)
                dispatch.perform(with: action)
            }
        )
    }
}
