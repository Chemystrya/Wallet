//
//  UIViewController+TransitionHandler.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

import UIKit

extension UIViewController: TransitionHandler {
    func replaceTopviewController(with viewController: UIViewController, animated: Bool) {
        guard var viewControllers = navigationController?.viewControllers else { return }
        viewController.hidesBottomBarWhenPushed = true
        if !viewControllers.isEmpty {
            viewControllers.removeLast()
        }
        viewControllers.append(viewController)
        navigationController?.setViewControllers(viewControllers, animated: animated)
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
