//
//  CoinsListAssembly.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import UIKit

enum CoinsListAssembly {
    static func assemble() -> UIViewController {
        let httpClient = HttpClientImpl()
        let service = CoinsListServiceImpl(httpClient: httpClient)
        let loginService = LoginServiceImpl()
        let router = CoinsListRouterImpl(loginService: loginService)
        let viewModel = CoinsListViewModelImpl(service: service, router: router)
        let viewController = CoinsListViewController(viewModel: viewModel)
        router.transitionHandler = viewController

        return viewController
    }
}
