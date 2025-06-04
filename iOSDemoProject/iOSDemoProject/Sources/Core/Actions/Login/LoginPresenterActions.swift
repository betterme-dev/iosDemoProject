//
//  LoginPresenterActions.swift
//
//
//  Created by Serhii Onopriienko on 13.04.2021.
//

import ReduxCore
import Foundation

extension Actions {
    enum LoginPresenter {
        struct EmailDidChange: Action {
            let email: String
            init(email: String) {
                self.email = email
            }
        }
        
        struct PasswordDidChange: Action {
            let password: String
            
            init(password: String) {
                self.password = password
            }
        }
        
        struct SignIn: Action {
            let email: String
            let password: String
            
            init(email: String, password: String) {
                self.email = email
                self.password = password
            }
        }
    }
}
