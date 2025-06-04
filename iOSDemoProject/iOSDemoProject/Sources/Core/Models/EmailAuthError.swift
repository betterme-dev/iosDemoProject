//
//  EmailAuthError.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation

enum EmailAuthError: Equatable, Codable {
    case credentialInvalid
    case general(String)
}
