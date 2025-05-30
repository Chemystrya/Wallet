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

    func back(animated: Bool, completion: (() -> Void)?) {
        guard let navigationController = navigationController else {
            dismiss(animated: animated, completion: completion)
            return
        }

        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: animated)
            if let coordinator = navigationController.transitionCoordinator, animated {
                coordinator.animate(alongsideTransition: nil) { _ in completion?() }
            } else {
                completion?()
            }
        } else {
            navigationController.dismiss(animated: animated, completion: completion)
        }
    }

    func replaceNavigationStack(
        with viewControllers: [UIViewController],
        animated: Bool,
        hidesTabBarWhenPushed: Bool
    ) {
        viewControllers.forEach { $0.hidesBottomBarWhenPushed = hidesTabBarWhenPushed }
        navigationController?.setViewControllers(viewControllers, animated: animated)
    }
}
