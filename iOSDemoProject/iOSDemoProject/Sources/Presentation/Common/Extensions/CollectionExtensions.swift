//
//  CollectionTypeExtensions.swift
//  Betterme
//
//  Created by Vitaliy Malakhovskiy on 8/10/17.
//  Copyright © 2017 Genesis Media. All rights reserved.
//

import Foundation

public extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }

    subscript(safe index: Index) -> Iterator.Element? {
        indices.contains(index) ? self[index] : nil
    }

    /// Inserts elements of this collection into a new dictionary.
    /// - Parameter keyPath: The keyPath to the property of the element that should be a key for this element.
    /// - Returns: A new dictionary with elements from this collection that are associated with keys that are extracted from the elements with a given keyPath.
    func normalized<Key: Hashable>(by keyPath: KeyPath<Element, Key>) -> [Key: Element] {
        reduce(into: [:]) { acc, element in
            acc[element[keyPath: keyPath]] = element
        }
    }
}

public extension Collection where Element: Identifiable {
    /// Inserts elements of this collection into a new dictionary.
    /// - Returns: A new dictionary with elements from this collection that are associated with the ID of the elements.
    func normalized() -> [Element.ID: Element] {
        reduce(into: [:]) { acc, element in
            acc[element.id] = element
        }
    }
}

public extension MutableCollection {
    subscript(safe index: Index) -> Iterator.Element? {
        set {
            if indices.contains(index), let newValue = newValue {
                self[index] = newValue
            }
        }
        get {
            indices.contains(index)
                ? self[index]
                : nil
        }
    }
}
