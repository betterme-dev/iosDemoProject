//
//  CustomOperators.swift
//  BetterMen
//
//  Created by Vadym Mitin on 03.04.2023.
//  Copyright © 2023 Genesis Media. All rights reserved.
//

import Foundation

func | <T>(_ object: T, block: (inout T) -> Void) -> T {
    modified(object, block: block)
}

func modified<T>(_ object: T, block: (inout T) -> Void) -> T {
    var newObject = object
    block(&newObject)
    return newObject
}
