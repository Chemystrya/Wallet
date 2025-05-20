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
}
