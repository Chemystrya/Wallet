//
//  CoinDetailsRouter.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//

protocol CoinDetailsRouter {
    func back()
    func logout()
}

final class CoinDetailsRouterImpl: BaseRouter, CoinDetailsRouter {}
