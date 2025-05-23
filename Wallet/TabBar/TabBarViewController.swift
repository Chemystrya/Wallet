//
//  TabBarViewController.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//
import UIKit

class TabItemViewController: UIViewController {
    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(
            title: nil,
            image: image?.withRenderingMode(.alwaysOriginal).resized(to: CGSize(width: 24, height: 24)),
            selectedImage: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Tab Bar Controller

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка чтобы не отображать подписи под иконками
        tabBar.unselectedItemTintColor = .gray // цвет неактивных иконок
        tabBar.tintColor = .systemBlue // цвет активной иконки

        let config = [
            Image.homeIcon.image,
            Image.ratingIcon.image,
            Image.walletIcon.image,
            Image.sheetIcon.image,
            Image.profileIcon.image
        ]

        viewControllers = config.map { image in
            let viewController = TabItemViewController(image: image)
            viewController.view.backgroundColor = .white
            return viewController
        }
    }
}
