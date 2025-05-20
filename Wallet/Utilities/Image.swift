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

    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
