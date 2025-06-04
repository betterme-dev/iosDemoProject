//
//  AuthTokenInfoResponse.swift
//  BMRequests
//
//  Created by Andrey Bogushev on 07.07.2022.
//  Copyright © 2022 BetterMe. All rights reserved.
//

import Foundation

struct AuthTokenInfoResponse: Decodable {
    let accessToken: String
    let expiresInTimestamp: Int
    let tokenType: String
    let refreshToken: String
}
