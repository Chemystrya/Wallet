//
//  LoginRouter.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

import UIKit

protocol LoginRouter {
    func openCoinsListScreen()
}

final class LoginRouterImpl: LoginRouter {
    weak var transitionHandler: TransitionHandler?

    func openCoinsListScreen() {
        let viewController = CoinsListAssembly.assemble()
        transitionHandler?.replaceTopviewController(with: viewController, animated: true)
    }
}

