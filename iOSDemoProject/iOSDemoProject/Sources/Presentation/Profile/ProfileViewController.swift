//
//  ProfileViewController.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit

#if DEBUG
import SwiftUI
#endif

final class ProfileViewController: UIViewController {
    struct Props: Equatable {
        let avatarURL: URL?
        let fullName: String
        let dateOfBirth: DateComponents
        let about: String
        let onLogOut: Command
        let onDestroy: Command
        
        static let initial = Props(
            avatarURL: nil,
            fullName: "",
            dateOfBirth: DateComponents(),
            about: "",
            onLogOut: .nop,
            onDestroy: .nop
        )
    }
    
    private var willAppearObservers: [() -> Void] = []
    private var didDisappearObservers: [() -> Void] = []
    private var props = Props.initial
    
    private let avatarImageView = UIImageView()
    private let fullNameLabel = UILabel()
    private let dateOfBirthLabel = UILabel()
    private let separatorView = UIView()
    private let aboutLabel = UILabel()
    
    private let dateFormater = DateFormatter()
    
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
        
        fullNameLabel.text = props.fullName
        
        if let date = Calendar.autoupdatingCurrent.date(from: props.dateOfBirth) {
            dateOfBirthLabel.text = dateFormater.string(from: date)
        }
        
        aboutLabel.text = props.about
    }

    func addWillAppearObserver(_ block: @escaping () -> Void) {
        willAppearObservers.append(block)
    }

    func addDidDisappearObserver(_ block: @escaping () -> Void) {
        didDisappearObservers.append(block)
    }
}

// MARK: - Private methods
private extension ProfileViewController {
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(onLogoutTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(onEditTap))
        
        avatarImageView.backgroundColor = UIColor(hexString: "#E5E5EA")
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.clipsToBounds = true
        
        fullNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        fullNameLabel.textColor = .black
        fullNameLabel.textAlignment = .center
        
        dateOfBirthLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        dateOfBirthLabel.textColor = .black
        dateOfBirthLabel.textAlignment = .center
        
        dateFormater.timeStyle = .none
        dateFormater.dateStyle = .medium
        
        separatorView.backgroundColor = .black.withAlphaComponent(0.2)
        
        aboutLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        aboutLabel.textColor = UIColor(hexString: "#8A8A8E")
        aboutLabel.numberOfLines = 0
    }
    
    func configureLayout() {
        [
            avatarImageView,
            fullNameLabel,
            dateOfBirthLabel,
            separatorView,
            aboutLabel,
        ].forEach(view.addSubview)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        dateOfBirthLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(dateOfBirthLabel.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview()
        }
        
        aboutLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    @objc func onLogoutTap() {
        props.onLogOut.perform()
    }
    
    @objc func onEditTap() {}
}

#if DEBUG
struct ProfileViewController_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PreviewDeviceModifier.defaultDevices()) {
                UIViewControllerPreview {
                    let vc = ProfileViewController()
                    vc.render(
                        props: ProfileViewController.Props(
                            avatarURL: nil,
                            fullName: "Shawn Howard",
                            dateOfBirth: DateComponents(year: 2000, month: 1, day: 1),
                            about: "One answer is that Truth pertains to the possibility that an event will occur. If true – it must occur and if false, it cannot occur. This is a binary world of extreme existential.",
                            onLogOut: .nop,
                            onDestroy: .nop
                        )
                    )
                    return UINavigationController(rootViewController: vc)
                }.modifier($0)
            }
        }
    }
}
#endif
