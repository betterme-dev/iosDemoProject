//
//  CredentialsValidator.swift
//  Betterme
//
//  Created by Serhii Onopriienko on 03.03.2020.
//  Copyright © 2020 BetterMe. All rights reserved.
//

import Foundation

enum CredentialsValidator {
    static func isValid(email: String) -> Bool {
        let pattern = "^[a-zA-Z0-9!#$%&\\'*+\\/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&\\'*+\\/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil && email.count <= 100
    }
    
    static func isValid(password: String) -> Bool {
        let pattern = "^[A-Za-z\\d@$!%*#?&.\\-]{6,24}$"
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex.firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.count)) != nil
    }
}
