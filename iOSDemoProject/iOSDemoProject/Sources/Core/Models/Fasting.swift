//
//  Fasting.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 09.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

struct Fasting: Equatable, Codable {
    let id: String
    let name: String
    let fastingHours: Int
    let eatingHours: Int
    let description: String
}
