//
//  ApplicationActions.swift
//  
//
//  Created by Vadym Mitin on 16.01.2023.
//

import ReduxCore

public extension Actions {
    enum Application {
        public struct DidFinishLaunch: Action {
            public let launchOptions: String?
            
            public init(launchOptions: String? = nil) {
                self.launchOptions = launchOptions
            }
        }

        public struct DidEnterBackground: Action {
            public init() {}
        }

        public struct DidBecomeActive: Action {
            public init() {}
        }

        public struct WillResignActive: Action {
            public init() {}
        }

        public struct WillEnterForeground: Action {
            public init() {}
        }
        
        public struct WillTerminate: Action {
            public init() {}
        }
    }
}
