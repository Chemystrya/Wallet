//
//  NavigationView.swift
//  Wallet
//
//  Created by Fedorova Maria on 03.06.2025.
//

import UIKit

struct NavigationViewModel {
    let title: String?
    let backgroundColor: UIColor
    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?
}

final class NavigationView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.medium.name, size: 14)
        label.textColor = .mirage
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image: UIImage? = Image.arrowLeftIcon.image?.resized(to: CGSize(width: 24, height: 24))
        button.setImage(image, for: .normal)
        button.tintColor = .mirage
        button.backgroundColor = .white
        button.alpha = 0.8
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.leftButtonAction?()
        }), for: .touchUpInside)

        return button
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), for: .normal)
        button.tintColor = .mirage
        button.backgroundColor = .white
        button.alpha = 0.8
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.rightButtonAction?()
        }), for: .touchUpInside)

        return button
    }()

    private var leftButtonAction: (() -> Void)?
    private var rightButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(logoutButton)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            backButton.topAnchor.constraint(equalTo: topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 48),

            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            logoutButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            logoutButton.topAnchor.constraint(equalTo: topAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 48),
            logoutButton.heightAnchor.constraint(equalToConstant: 48),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: -16)
        ])
    }

    func configure(viewModel: NavigationViewModel) {
        if let title = viewModel.title {
            titleLabel.text = title
        }

        leftButtonAction = viewModel.leftButtonAction
        rightButtonAction = viewModel.rightButtonAction
        backgroundColor = viewModel.backgroundColor
    }
}
