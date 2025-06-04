//
//  CoinDetailsAssembly.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//
import UIKit

enum CoinDetailsAssembly {
    static func assemble(coin: Coin) -> UIViewController {
        let loginService = LoginServiceImpl()
        let router = CoinDetailsRouterImpl(loginService: loginService)
        let viewModel = CoinDetailsViewModelImpl(coinDetails: coin, router: router)
        let viewController = CoinDetailsViewController(viewModel: viewModel)
        router.transitionHandler = viewController

        return viewController
    }
}
