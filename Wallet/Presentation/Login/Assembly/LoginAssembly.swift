//
//  LoginAssembly.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//
import UIKit

enum LoginAssembly {
    static func assemble() -> UIViewController {
        let router = LoginRouterImpl()
        let service = LoginServiceImpl()
        let viewModel = LoginViewModel(service: service, router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        router.transitionHandler = viewController

        return viewController
    }
}
