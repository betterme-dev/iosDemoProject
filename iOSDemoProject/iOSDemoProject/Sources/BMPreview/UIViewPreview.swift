//
//  UIViewPreview.swift
//  Heart
//
//  Created by AndreyRogulin on 14.01.2020.
//  Copyright © 2020 BetterMe. All rights reserved.
//

import UIKit

#if DEBUG
import SwiftUI

@available(iOS 13, *)
public enum ViewPreviewFitSize {
    case fitWidth(CGFloat)
    case fitHeight(CGFloat)
    case `default`
}

@available(iOS 13, *)
public final class PreviewContainerView: UIView {
    let childView: UIView
    let fitSize: ViewPreviewFitSize
    var fittingSize: CGSize?
    
    public override func invalidateIntrinsicContentSize() {
        fittingSize = nil
        fittingSize = calculateSize()
    }
    
    public override var intrinsicContentSize: CGSize {
        fittingSize ?? super.intrinsicContentSize
    }
    
    public init(fitSize: ViewPreviewFitSize, view: UIView) {
        self.childView = view
        self.fitSize = fitSize
        
        super.init(frame: .zero)
        
        configureUI()
        
        self.fittingSize = calculateSize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        childView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(childView)
        NSLayoutConstraint.activate(
            [
                childView.topAnchor.constraint(equalTo: topAnchor),
                childView.trailingAnchor.constraint(equalTo: trailingAnchor),
                childView.leadingAnchor.constraint(equalTo: leadingAnchor),
                childView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ]
        )
    }
    
    private func calculateSize() -> CGSize {
        switch fitSize {
        case .fitHeight(let height):
            return childView.systemLayoutSizeFitting(
                CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
                withHorizontalFittingPriority: .fittingSizeLevel,
                verticalFittingPriority: .required
            )
        case .fitWidth(let width):
            return childView.systemLayoutSizeFitting(
                CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
        case .default:
            return childView.intrinsicContentSize
        }
    }
}

@available(iOS 13, *)
public struct UIViewPreview<View: PreviewContainerView, T: UIView>: UIViewRepresentable {
    let view: PreviewContainerView
    let fitSize: ViewPreviewFitSize
    
    public init(
        fit: ViewPreviewFitSize = .default,
        _ builder: @escaping () -> T
    ) {
        self.fitSize = fit
        self.view = PreviewContainerView(fitSize: fit, view: builder())
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> UIView {
        view.invalidateIntrinsicContentSize()
        return view
    }
    
    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
