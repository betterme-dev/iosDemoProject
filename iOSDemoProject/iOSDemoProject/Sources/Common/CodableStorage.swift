//
//  CodableStorage.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation

enum CodableStorageError: Swift.Error {
    case emptyData
}

final class CodableStorage<T: Codable> {
    private let userDefaults = UserDefaults.standard
    private let key = String(reflecting: T.self)
    
    func store(_ data: T) throws {
        userDefaults.set(try JSONEncoder().encode(data), forKey: key)
    }
    
    func fetch() throws -> T {
        guard let data = userDefaults.data(forKey: key) else {
            throw CodableStorageError.emptyData
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func clear() throws {
        userDefaults.removeObject(forKey: key)
    }
}
