//
//  LoginRouter.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

import UIKit

protocol LoginRouter {
    func openHomeScreen()
}

final class LoginRouterImpl: LoginRouter {
    weak var transitionHandler: TransitionHandler?

    func openHomeScreen() {
        let viewController = UIViewController()
        transitionHandler?.replaceTopviewController(with: viewController, animated: true)
    }
}

