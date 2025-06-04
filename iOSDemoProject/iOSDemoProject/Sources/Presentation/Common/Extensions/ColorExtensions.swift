//
//  ColorExtensions.swift
//  Onboarding
//
//  Created by Dmytro Solohub on 18.11.2022.
//  Copyright © 2022 BetterMe. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    private enum RGBA: Int {
        case red; case green; case blue; case alpha
    }
    
    // string in format "r:g:b:a" and colors in 255 representation
    convenience init(rgbaString: String) {
        var assoc: [RGBA: CGFloat] = [.red: 0, .green: 0, .blue: 0, .alpha: 0]
        
        let components = rgbaString.components(separatedBy: ":")
        for i in 0 ..< components.count {
            let component = components[i]
            if let rgbIndex = RGBA(rawValue: i),
               let floatValue = Float(component) {
                let number = CGFloat(floatValue) / 255
                assoc[rgbIndex] = number
            }
        }
        self.init(red: assoc[.red]!, green: assoc[.green]!, blue: assoc[.blue]!, alpha: assoc[.alpha]!)
    }
}
