//
//  CoinsListRouter.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import UIKit

protocol CoinsListRouter {
    func openCoinDetailScreen(coin: Coin)
}

final class CoinsListRouterImpl: CoinsListRouter {
    weak var transitionHandler: TransitionHandler?

    func openCoinDetailScreen(coin: Coin) {
        let viewController = UIViewController()
        transitionHandler?.push(viewController: viewController, animated: true)
    }
}
