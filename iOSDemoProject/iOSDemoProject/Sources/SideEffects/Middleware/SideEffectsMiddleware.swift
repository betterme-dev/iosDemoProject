//
//  SideEffectsMiddleware.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import ReduxCore
import Foundation

final class SideEffectsMiddleware {
    private var emailSignInController: EmailSignInController?
    private var storeBackupController: StoreBackupController?
    
    func middleware() -> Middleware<AppState> {
        { (_, action: Action, _, newState: AppState) in
            switch action {
            case is Actions.Application.DidFinishLaunch:
                self.emailSignInController = EmailSignInFactory().default()
                self.storeBackupController = StoreBackupFactory().default()
                
            default:
                break
            }
        }
    }
}
