//
//  ActiveFastingViewController.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit
import BMCommand
#if DEBUG
import SwiftUI
import BMPreview
#endif

final class ActiveFastingViewController: UIViewController {
    struct Props: Equatable {
        let onDestroy: Command
        
        static let initial = Props(
            onDestroy: .nop
        )
    }
    
    private var willAppearObservers: [() -> Void] = []
    private var didDisappearObservers: [() -> Void] = []
    private var props = Props.initial
    
    deinit {
        props.onDestroy.perform()
    }
    
    func render(props: Props) {
        guard self.props != props else { return }
        self.props = props
        view.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        configureAccessibilityIdentifier()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppearObservers.forEach { $0() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappearObservers.forEach { $0() }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }

    func addWillAppearObserver(_ block: @escaping () -> Void) {
        willAppearObservers.append(block)
    }

    func addDidDisappearObserver(_ block: @escaping () -> Void) {
        didDisappearObservers.append(block)
    }
}

// MARK: - Private methods
private extension ActiveFastingViewController {
    func configureAccessibilityIdentifier() {
        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { child in
            guard
                let view = child.value as? UIView,
                let identifier = child.label,
                view.accessibilityIdentifier == nil
            else {
                return
            }
            view.accessibilityIdentifier = "\(type(of: self)).\(identifier)"
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureLayout() {}
}

#if DEBUG
struct ActiveFastingViewController_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PreviewDeviceModifier.defaultDevices()) {
                UIViewControllerPreview {
                    let vc = ActiveFastingViewController()
                    vc.render(
                        props: ActiveFastingViewController.Props(
                            onDestroy: .nop
                        )
                    )
                    return vc
                }.modifier($0)
            }
        }
    }
}
#endif
