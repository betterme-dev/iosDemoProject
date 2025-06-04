//
//  ListCoordinator.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit
import ReduxCore

final class ListCoordinator: ChainCoordinator {
    var rootViewController: UIViewController {
        navigationController
    }

    private let navigationController: UINavigationController
    
    var next: ChainCoordinator?
    
    init() {
        self.navigationController = UINavigationController(rootViewController: ListScreenFactory().default())
        self.navigationController.tabBarItem = UITabBarItem(
            title: "List",
            image: UIImage(named: "list_tab_icon"),
            selectedImage: UIImage(named: "list_tab_icon_selected")
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
