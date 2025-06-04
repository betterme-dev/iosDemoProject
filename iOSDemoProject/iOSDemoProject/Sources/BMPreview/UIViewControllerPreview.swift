//
//  UIViewControllerPreview.swift
//  Heart
//
//  Created by AndreyRogulin on 14.01.2020.
//  Copyright © 2020 BetterMe. All rights reserved.
//

import UIKit

#if DEBUG
import SwiftUI
@available(iOS 13, *)
public struct UIViewControllerPreview<View: UIViewController>: UIViewControllerRepresentable {
    let viewController: View
    
    public init(_ builder: @escaping () -> View) {
        self.viewController = builder()
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIViewController(context: Context) -> View {
        viewController
    }
    
    public func updateUIViewController(_ uiViewController: View, context: UIViewControllerRepresentableContext<UIViewControllerPreview<View>>) {}
}
#endif
