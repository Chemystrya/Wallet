//
//  TabBarViewController.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//
import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray

        setTabs()

        tabBar.tintColor = .mirage
        tabBar.unselectedItemTintColor = .mischka
        tabBar.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    private func setTabs() {
        let coinsListViewController = CoinsListAssembly.assemble()
        setupTab(
            viewController: coinsListViewController,
            image: Image.homeIcon.image
        )
        let coinsNavigationController = UINavigationController(rootViewController: coinsListViewController)

        let ratingViewController = UIViewController()
        setupTab(
            viewController: ratingViewController,
            image: Image.ratingIcon.image
        )
        let ratingNavigationController = UINavigationController(rootViewController: ratingViewController)

        let walletViewController = UIViewController()
        setupTab(
            viewController: walletViewController,
            image: Image.walletIcon.image
        )
        let walletNavigationController = UINavigationController(rootViewController: walletViewController)

        let sheetViewController = UIViewController()
        setupTab(
            viewController: sheetViewController,
            image: Image.sheetIcon.image
        )
        let sheetNavigationController = UINavigationController(rootViewController: sheetViewController)

        let profileViewController = UIViewController()
        setupTab(
            viewController: profileViewController,
            image: Image.profileIcon.image
        )
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)

        let viewControllers = [coinsNavigationController, ratingNavigationController, walletNavigationController, sheetNavigationController, profileNavigationController]

        setViewControllers(viewControllers, animated: false)
    }

    private func setupTab(viewController: UIViewController, image: UIImage?) {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 35, left: 0, bottom: 15, right: 0)
    }
}
