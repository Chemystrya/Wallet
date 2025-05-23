//
//  CoinsListRouter.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import UIKit

protocol CoinsListRouter {
    func openCoinDetailScreen(coin: Coin)
    func logout()
}

final class CoinsListRouterImpl: BaseRouter, CoinsListRouter {
    func openCoinDetailScreen(coin: Coin) {
        let viewController = CoinDetailsAssembly.assemble(coin: coin)
        transitionHandler?.push(viewController: viewController, animated: true)
    }
}
