//
//  CoinDetailsViewModel.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//

protocol CoinDetailsViewModel {
    var coinDetails: Coin { get }

    func back()
    func logout()
}

final class CoinDetailsViewModelImpl: CoinDetailsViewModel {
    private(set) var coinDetails: Coin
    private let router: CoinDetailsRouter

    init(coinDetails: Coin, router: CoinDetailsRouter) {
        self.coinDetails = coinDetails
        self.router = router
    }

    func back() {
        router.back()
    }

    func logout() {
        router.logout()
    }
}
