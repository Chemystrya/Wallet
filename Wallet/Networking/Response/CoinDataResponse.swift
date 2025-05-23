//
//  CoinDataResponse.swift
//  Wallet
//
//  Created by Fedorova Maria on 23.05.2025.
//

struct CoinDataResponse: Decodable {
    let data: CoinResponse

    struct CoinResponse: Decodable {
        let name: String
        let symbol: String
        let marketData: MarketData
        let marketcap: Marketcap
        let supply: Supply
        let roiData: RoiData
        let allTimeHigh: AllTimeHigh
        let developerActivity: DeveloperActivity

        struct MarketData: Decodable {
            let priceUsd: Double
            let percentChangeUsdLast24Hours: Double
        }

        struct Marketcap: Decodable {
            let currentMarketcapUsd: Double
        }

        struct Supply: Decodable {
            let circulating: Double
        }

        struct RoiData: Decodable {
            let percentChangeLast1Week: Double?
            let percentChangeBtcLast1Week: Double?
            let percentChangeLast1Year: Double?
            let percentChangeBtcLast1Year: Double?
        }

        struct AllTimeHigh: Decodable {
            let price: Double?
            let percentDown: Double?
        }

        struct DeveloperActivity: Decodable {
            let stars: Int?
            let watchers: Int?
        }
    }
}
