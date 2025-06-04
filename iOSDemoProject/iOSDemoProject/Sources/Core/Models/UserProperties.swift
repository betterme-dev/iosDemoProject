//
//  UserProperties.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

struct UserProperties: Equatable, Codable {
    let fullName: String
    let avatarUrl: URL?
    let dateOfBirth: DateComponents
    let about: String
}
