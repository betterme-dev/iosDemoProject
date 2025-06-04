//
//  MainCoordinator.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit
import ReduxCore


final class MainCoordinator: NSObject, ChainCoordinator {
    var rootViewController: UIViewController {
        tabBarViewController
    }

    private let tabBarViewController: UITabBarController
    private let dispatch = CommandWith(action: StoreLocator.shared.dispatch)
    
    var next: ChainCoordinator?
    
    private let listCoordinator = ListCoordinator()
    private let fastingCoordinator = FastingCoordinator()
    private let profileCoordinator = ProfileCoordinator()
    
    override init() {
        self.tabBarViewController = UITabBarController()
        super.init()
        
        self.tabBarViewController.delegate = self
        
        configureTabBarAppearance()
        
        tabBarViewController.viewControllers = [
            listCoordinator.rootViewController,
            fastingCoordinator.rootViewController,
            profileCoordinator.rootViewController
        ]
    }
    
    func handle(state: AppState, action: Action) -> Bool {
        if next?.handle(state: state, action: action) == true {
            return true
        }
        
        switch action {
        case is Actions.MainCoordinator.ShowList:
            tabBarViewController.selectedIndex = 0
            return true
            
        case is Actions.MainCoordinator.ShowFasting:
            tabBarViewController.selectedIndex = 1
            return true
            
        case is Actions.MainCoordinator.ShowProfile:
            tabBarViewController.selectedIndex = 2
            return true
            
        default:
            return false
        }
    }
}

extension MainCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case listCoordinator.rootViewController:
            dispatch.perform(with: Actions.MainCoordinator.ShowList())
        case fastingCoordinator.rootViewController:
            dispatch.perform(with: Actions.MainCoordinator.ShowFasting())
        case profileCoordinator.rootViewController:
            dispatch.perform(with: Actions.MainCoordinator.ShowProfile())
        default:
            break
        }
        
        return false
    }
}

private extension MainCoordinator {
    func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        
        tabBarViewController.tabBar.standardAppearance = tabBarAppearance
        tabBarViewController.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
