//
//  PreviewDeviceModifier.swift
//  Heart
//
//  Created by AndreyRogulin on 15.01.2020.
//  Copyright © 2020 BetterMe. All rights reserved.
//

import Foundation

#if DEBUG
import SwiftUI
@available(iOS 13, *)
public struct PreviewDeviceModifier: ViewModifier, Swift.Identifiable {
    public static func defaultDevices() -> [PreviewDeviceModifier] {
        [
            iphone14Pro(),
            iphoneSE2022(),
        ]
    }
    
    public static func iphone11Pro() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
    
    public static func iphone12Pro() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPhone 12 Pro"))
    }
    
    public static func iphone13Pro() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
    
    public static func iphone14Pro() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
    
    public static func iphoneX() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPhone X"))
    }
    
    public static func iphone8() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPhone 8"))
    }
    
    public static func iphoneSE() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPhone SE"))
    }
    
    public static func iphoneSE2022() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
    
    public static func ipadAir2() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPad Air 2"))
    }
    
    public static func ipadPro97() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
    }
    
    public static func ipadPro11_2022() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
    }
    
    public static func ipad2022() -> PreviewDeviceModifier {
        PreviewDeviceModifier(previewDevice: PreviewDevice(rawValue: "iPad (10th generation)"))
    }
    
    public let id: String
    private let previewDevice: PreviewDevice
    
    public init(previewDevice: PreviewDevice) {
        self.id = UUID().uuidString
        self.previewDevice = previewDevice
    }
    
    public func body(content: Content) -> some View {
        content
            .previewDevice(previewDevice)
            .previewDisplayName(previewDevice.rawValue)
    }
}
#endif
