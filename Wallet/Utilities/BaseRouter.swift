//
//  BaseRouter.swift
//  Wallet
//
//  Created by Fedorova Maria on 23.05.2025.
//

import UIKit

class BaseRouter {
    weak var transitionHandler: TransitionHandler?

    private let loginService: LoginService

    init(loginService: LoginService) {
        self.loginService = loginService
    }

    func back() {
        transitionHandler?.back(animated: true, completion: nil)
    }

    func logout() {
        loginService.setLoggedIn(false)
        let loginViewController = LoginAssembly.assemble()
        transitionHandler?.replaceNavigationStack(with: [loginViewController], animated: true, hidesTabBarWhenPushed: true)
    }
}
