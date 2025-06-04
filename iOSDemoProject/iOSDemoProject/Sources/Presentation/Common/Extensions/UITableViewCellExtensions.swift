//
//  UITableViewCellExtensions.swift
//  QAPanel
//
//  Created by Yurii Chudnovets on 13.03.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static func reuseIdentifier() -> String {
        String(describing: self)
    }
}
