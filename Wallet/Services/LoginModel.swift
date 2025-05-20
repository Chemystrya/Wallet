//
//  LoginModel.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

import Foundation

protocol LoginService {
    func validate(username: String, password: String) -> Bool
    func login(username: String, password: String, completion: @escaping (Bool) -> Void)
    func isUserLoggedIn() -> Bool
    func setLoggedIn(_ loggedIn: Bool)
}

final class LoginServiceImpl: LoginService {
    func validate(username: String, password: String) -> Bool {
        return !username.isEmpty && !password.isEmpty
    }

    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        let success = username == "1234" && password == "1234"
        self.setLoggedIn(success)
        completion(success)
    }

    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    }

    func setLoggedIn(_ loggedIn: Bool) {
        UserDefaults.standard.set(loggedIn, forKey: "isUserLoggedIn")
    }
}
