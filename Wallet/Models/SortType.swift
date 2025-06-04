//
//  SortType.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//

enum SortType {
    case priceAsc
    case priceDesc

    var title: String {
        return switch self {
        case .priceAsc:
            Localizable.CoinsList.priceAsc
        case .priceDesc:
            Localizable.CoinsList.priceDesc
        }
    }
}
