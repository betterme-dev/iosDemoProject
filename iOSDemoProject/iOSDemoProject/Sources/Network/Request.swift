//
//  Request.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation


struct Request<T> {
    /// Returns a Command to cancel request
    let perform: (@escaping (Result<T, Error>) -> Void) -> Command
    
    init(perform: @escaping (@escaping (Result<T, Error>) -> Void) -> Command) {
        self.perform = perform
    }
}
