//
//  ProfileCoordinator.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit
import ReduxCore

final class ProfileCoordinator: ChainCoordinator {
    var rootViewController: UIViewController {
        navigationController
    }

    private let navigationController: UINavigationController
    
    var next: ChainCoordinator?
    
    init() {
        self.navigationController = UINavigationController(rootViewController: ProfileScreenFactory().default())
        self.navigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile_tab_icon"),
            selectedImage: UIImage(named: "profile_tab_icon_selected")
        )
    }
    
    func handle(state: AppState, action: Action) -> Bool {
        if next?.handle(state: state, action: action) == true {
            return true
        }
        
        switch action {
        
        default:
            return false
        }
    }
}
