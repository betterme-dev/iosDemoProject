//
//  ActiveFastingViewController.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 08.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit

#if DEBUG
import SwiftUI
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
    
    private let emptyLabel = UILabel()
    
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
    func configureUI() {
        view.backgroundColor = .white
        
        emptyLabel.text = "Fasting is not selected"
        emptyLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        emptyLabel.textColor = UIColor(hexString: "#8E8E93")
    }
    
    func configureLayout() {
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
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
