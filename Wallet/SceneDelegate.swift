//
//  SceneDelegate.swift
//  Wallet
//
//  Created by Fedorova Maria on 19.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let loginViewController = LoginAssembly.assemble()
        let navigationController = UINavigationController(rootViewController: loginViewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

