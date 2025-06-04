//
//  Coin.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.

import UIKit

struct Coin {
    let name: String
    let symbol: String
    let priceUsd: Double
    let percentChangeUsdLast24Hours: Double
    let currentMarketcapUsd: Double
    let circulating: Double
    let percentChangeLast1Week: Double
    let percentChangeBtcLast1Week: Double
    let percentChangeLast1Year: Double
    let percentChangeBtcLast1Year: Double
    let price: Double
    let percentDown: Double
    let stars: Int
    let watchers: Int
}
