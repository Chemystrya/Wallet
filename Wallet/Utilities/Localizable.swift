//
//  Localizable.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

enum Localizable {
    enum Login {
        static let username = "Login.username".localized
        static let password = "Login.password".localized
        static let login = "Login.login".localized
    }
    
    enum Error {
        static let error = "Error.error".localized
        static let incorrectLoginOrPassword = "Error.incorrectLoginOrPassword".localized
        static let repeatAgain = "Error.repeat".localized
        static let cancel = "Error.cancel".localized
    }

    enum CoinsList {
        static let learnMore = "CoinsList.learnMore".localized
        static let affiliateProgram = "CoinsList.affiliateProgram".localized
        static let home = "CoinsList.home".localized
        static let trending = "CoinsList.trending".localized
        static let priceAsc = "CoinsList.byPriceAscending".localized
        static let priceDesc = "CoinsList.byPriceDescending".localized
        static let update = "CoinsList.update".localized
        static let goOut = "CoinsList.goOut".localized
        static let sortingPrinciple = "CoinsList.sortingPrinciple".localized
    }

    enum CoinDetail {
        static let twentyFourHours = "CoinDetails.twentyFourHours".localized
        static let oneWeek = "CoinDetails.oneWeek".localized
        static let oneYear = "CoinDetails.oneYear".localized
        static let all = "CoinDetails.all".localized
        static let point = "CoinDetails.point".localized
        static let marketStatistic = "CoinDetails.marketStatistic".localized
        static let marketCapitalization = "CoinDetails.marketCapitalization".localized
        static let circulatingSuply = "CoinDetails.circulatingSuply".localized
        static let changelastOneWeek = "CoinDetails.changelastOneWeek".localized
        static let changeBtcLastOneWeek = "CoinDetails.changeBtcLastOneWeek".localized
        static let changeLastOneYear = "CoinDetails.changeLastOneYear".localized
        static let changeBtcLastOneYear = "CoinDetails.changeBtcLastOneYear".localized
        static let price = "CoinDetails.price".localized
        static let percentDown = "CoinDetails.percentDown".localized
        static let stars = "CoinDetails.stars".localized
        static let watchers = "CoinDetails.watchers".localized
    }
}
