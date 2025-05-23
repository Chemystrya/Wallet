//
//  Image.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

import UIKit

enum Image: String {
    case loginRobot
    case passwordIcon
    case usernameIcon

    case coinsListStack
    case shadowForCoinsListStack
    case sortButtonIcon
    case garbageIcon
    case rocketIcon
    case arrowUpIcon
    case arrowDownIcon
    case ellipsisIcon

    case arrowLeftIcon

    case homeIcon
    case ratingIcon
    case walletIcon
    case sheetIcon
    case profileIcon

    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
