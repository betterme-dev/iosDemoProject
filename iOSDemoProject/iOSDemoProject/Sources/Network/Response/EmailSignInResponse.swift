//
//  EmailSignInResponse.swift
//  Betterme
//
//  Created by Serhii Onopriienko on 19.02.2020.
//  Copyright © 2020 BetterMe. All rights reserved.
//

import Foundation

struct EmailSignInResponse: Decodable {
    let userProperties: UserPropertiesResponse
    let emailAccount: EmailAccountResponse
    let auth: AuthTokenInfoResponse
}
