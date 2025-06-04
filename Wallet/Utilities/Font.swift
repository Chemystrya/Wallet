//
//  Font.swift
//  Wallet
//
//  Created by Fedorova Maria on 23.05.2025.
//

enum Font {
    case medium
    case semiBold

    var name: String {
        switch self {
        case .medium:
            "Poppins-Medium"
        case .semiBold:
            "Poppins-SemiBold"
        }
    }
}
