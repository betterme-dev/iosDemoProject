//
//  FastingLoadingController.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 09.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//


import Foundation

public final class FastingLoadingController: NSObject {
    struct Props: Equatable {
        enum State: Equatable {
            case idle
            case loading(onSuccess: CommandWith<ResponseData>, onFailure: CommandWith<Error>)
        }
        
        struct ResponseData: Equatable {
            let fastings: [Fasting]
        }
        
        let state: State
        let onDestroy: Command
        static let initial = FastingLoadingController.Props(state: .idle, onDestroy: .nop)
    }
    
    private let requestManager: RequestManager
    private var props: FastingLoadingController.Props = .initial
    private var cancel: Command?
    
    deinit {
        props.onDestroy.perform()
    }
    
    init(
        requestManager: RequestManager
    ) {
        self.requestManager = requestManager
    }
    
    func render(props: FastingLoadingController.Props) {
        guard self.props != props else { return }
        
        cancel?.perform()
        cancel = nil
        self.props = props
        
        switch props.state {
        case .idle:
            break
        case let .loading(onSuccess, onFailure):
            loadFasting(onSuccess: onSuccess, onFailure: onFailure)
        }
    }
    
    private func loadFasting(onSuccess: CommandWith<FastingLoadingController.Props.ResponseData>, onFailure: CommandWith<Error>) {
        cancel = requestManager.v5FastingsGet().perform { result in
            switch result {
            case .success(let response):
                let responseData = FastingLoadingController.Props.ResponseData(
                    fastings: response
                )
                
                onSuccess.perform(with: responseData)
                
            case .failure(let error):
                onFailure.perform(with: error)
            }
        }
    }
}
