//
//  ContainerViewController.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import UIKit


final class ContainerViewController: UIViewController {
    private weak var contentController: UIViewController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle { contentController?.preferredStatusBarStyle ?? .default }
    
    var handleShake: Command?
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        handleShake?.perform()
    }
    
    func displayContentController(_ contentController: UIViewController?) {
        removeContentController()
        
        guard let contentController = contentController else { return }
        
        self.contentController = contentController
        addChild(contentController)
        contentController.view.frame = view.bounds
        view.addSubview(contentController.view)
        contentController.didMove(toParent: self)
        setNeedsStatusBarAppearanceUpdate()
        setNeedsUpdateOfHomeIndicatorAutoHidden()
    }
    
    func removeContentController() {
        dismiss(animated: false, completion: nil)
        contentController?.dismiss(animated: false, completion: nil)
        contentController?.willMove(toParent: nil)
        contentController?.view.removeFromSuperview()
        contentController?.removeFromParent()
        contentController = nil
    }
}
