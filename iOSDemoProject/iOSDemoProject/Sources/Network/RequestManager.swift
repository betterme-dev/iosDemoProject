//
//  RequestManager.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

protocol RequestManager {
    func v5EmailSingInPost(email: String, password: String) -> Request<EmailSignInResponse>
    func v5SingOutPost() -> Request<Void>
    func v5FastingsGet() -> Request<[Fasting]>
}
