//
//  AuthTokenInfo.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation

struct AuthTokenInfo: Equatable, Codable {
    let accessToken: String
    let expiresInTimestamp: Int
    let tokenType: String
    let refreshToken: String
}
