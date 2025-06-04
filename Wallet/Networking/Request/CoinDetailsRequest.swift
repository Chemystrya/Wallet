//
//  CoinDetailsRequest.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import Foundation

struct CoinDetailsRequest: Request {
    typealias ResponseType = CoinDataResponse

    private let symbol: String

    init(symbol: String) {
        self.symbol = symbol
    }

    var url: URL? {
        URL(string: "\(Constants.baseUrlString)/\(symbol)/metrics")
    }
}
