//
//  TransitionHandler.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

import UIKit

protocol TransitionHandler: AnyObject {
    func replaceTopviewController(with viewController: UIViewController, animated: Bool)
    func push(viewController: UIViewController, animated: Bool)
    func back(animated: Bool, completion: (() -> Void)?)
    func replaceNavigationStack(
        with viewControllers: [UIViewController],
        animated: Bool,
        hidesTabBarWhenPushed: Bool
    )
}
