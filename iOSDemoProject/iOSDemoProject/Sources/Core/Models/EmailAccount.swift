//
//  EmailAccount.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation

struct EmailAccount: Equatable, Codable {
    let email: String
    let confirmed: Bool
}
