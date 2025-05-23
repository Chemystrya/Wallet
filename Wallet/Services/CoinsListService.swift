//
//  CoinsListService.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import Foundation

protocol CoinsListService {
    func fetchCoins(completionHandler: @escaping ([Coin]) -> Void)
}

final class CoinsListServiceImpl: CoinsListService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchCoins(completionHandler: @escaping ([Coin]) -> Void) {
        var coins: [Coin] = []
        let symbols = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
        let dispatchGroup = DispatchGroup()
        
        for symbol in symbols {
            dispatchGroup.enter()
            fetchCoinDetails(symbol: symbol) { coin in
                coins.append(coin)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completionHandler(coins)
        }
    }
}

extension CoinsListServiceImpl {
    private func fetchCoinDetails(symbol: String, completionHandler: @escaping (Coin) -> Void) {
        let request = CoinDetailsRequest(symbol: symbol)
        httpClient.send(request) { result in
            switch result {
            case .success(let coinResponse):
                completionHandler(
                    Coin(
                        name: coinResponse.data.name,
                        symbol: coinResponse.data.symbol,
                        priceUsd: coinResponse.data.marketData.priceUsd,
                        percentChangeUsdLast24Hours: coinResponse.data.marketData.percentChangeUsdLast24Hours,
                        currentMarketcapUsd: coinResponse.data.marketcap.currentMarketcapUsd,
                        circulating: coinResponse.data.supply.circulating,
                        percentChangeLast1Week: coinResponse.data.roiData.percentChangeLast1Week ?? 0,
                        percentChangeBtcLast1Week: coinResponse.data.roiData.percentChangeBtcLast1Week ?? 0,
                        percentChangeLast1Year: coinResponse.data.roiData.percentChangeLast1Year ?? 0,
                        percentChangeBtcLast1Year: coinResponse.data.roiData.percentChangeBtcLast1Year ?? 0,
                        price: coinResponse.data.allTimeHigh.price ?? 0,
                        percentDown: coinResponse.data.allTimeHigh.percentDown ?? 0,
                        stars: coinResponse.data.developerActivity.stars ?? 0,
                        watchers: coinResponse.data.developerActivity.watchers ?? 0
                    )
                )
            case .failure(let error):
                print(error)
            }
        }
    }
}
