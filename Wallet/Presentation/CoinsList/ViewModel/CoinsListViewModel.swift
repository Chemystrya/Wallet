//
//  CoinsListViewModel.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import Foundation

protocol CoinsListViewModel {
    var coins: [Coin] { get }
    var currentSortType: SortType { get }

    func fetchCoins(completionHandler: @escaping () -> Void)
    func setSortType(_ sortType: SortType)
    func openCoinDetailScreen(index: Int)
    func logout()
}

final class CoinsListViewModelImpl: CoinsListViewModel {
    private let router: CoinsListRouter
    private let service: CoinsListService

    private(set) var coins: [Coin] = []
    private(set) var currentSortType: SortType = .priceAsc

    init(service: CoinsListService, router: CoinsListRouter) {
        self.service = service
        self.router = router
    }

    func fetchCoins(completionHandler: @escaping () -> Void) {
        service.fetchCoins { [weak self] coins in
            self?.coins = coins
            completionHandler()
        }
    }

    func openCoinDetailScreen(index: Int) {
        let coin = coins[index]
        router.openCoinDetailScreen(coin: coin)
    }

    func logout() {
        router.logout()
    }

    func setSortType(_ sortType: SortType) {
        currentSortType = sortType

        switch currentSortType {
        case .priceAsc:
            coins.sort { $0.priceUsd < $1.priceUsd }
        case .priceDesc:
            coins.sort { $0.priceUsd > $1.priceUsd }
        }
    }
}
