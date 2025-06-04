//
//  AppCoordinator.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import UIKit
import ReduxCore

final class AppCoordinator: ChainCoordinator {
    let window: UIWindow
    
    var rootViewController: UIViewController {
        containerController
    }
    
    private let containerController = ContainerViewController()
    
    var next: ChainCoordinator?
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        configure()
    }
    
    private func configure() {
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
        window.rootViewController = containerController
        containerController.displayContentController(AppLaunchViewController())
    }
    
    func handle(state: AppState, action: Action) -> Bool {
        if next?.handle(state: state, action: action) == true {
            return true
        }
        
        switch action {
        case is Actions.NavigationMiddleware.ShowLogin:
            let vc = LoginScreenFactory().default()
            containerController.displayContentController(vc)
            return true
            
        case is Actions.NavigationMiddleware.ShowMain:
            let mainCoordinator = MainCoordinator()
            next = mainCoordinator
            containerController.displayContentController(mainCoordinator.rootViewController)
            return true
            
        case is Actions.LoginPresenter.SignIn:
            showLoader()
            return true
            
        case is Actions.EmailSignInPresenter.Succeeded,
             is Actions.EmailSignInPresenter.Failed:
            hideLoader()
            return true
            
        case is Actions.ProfilePresenter.SignOut:
            guard case .email(.loggingOut) = state.auth else { return false }
            showLoader()
            return true
            
        case is Actions.EmailSignInPresenter.SignOutSuccess:
            hideLoader()
            return true
            
        default:
            return false
        }
    }
}

private extension AppCoordinator {
    func showLoader() {
        let viewController = LoaderViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        containerController.present(viewController, animated: true)
    }
    
    func hideLoader() {
        containerController.dismiss(animated: false)
    }
}
