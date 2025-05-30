//
//  CustomDropdownMenu.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//

import UIKit

final class MenuItemView: UIView {
    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    var imageName: String = "" {
        didSet {
            imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        }
    }

    var actionHandler: (() -> Void)?

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .mirage
        label.font = UIFont(name: Font.medium.name, size: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func commonInit() {
        backgroundColor = .white

        addSubview(imageView)
        addSubview(label)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),

            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    @objc private func handleTap() {
        actionHandler?()
    }
}

final class CustomDropdownMenu: UIView {
    private var menuItemViews: [MenuItemView] = []

    var onItemSelected: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setupButtons(items: [(image: String, title: String)]) {
        for (image, title) in items {
            let item = MenuItemView()
            item.imageName = image
            item.title = title
            item.actionHandler = { [weak self] in
                guard let self = self else { return }
                self.onItemSelected?(title)
                self.removeFromSuperview()
            }
            menuItemViews.append(item)
            addSubview(item)
        }

        layoutItems()
    }

    private func layoutItems() {
        for (index, view) in menuItemViews.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.heightAnchor.constraint(equalToConstant: 51)
            ])

            if index == 0 {
                view.topAnchor.constraint(equalTo: topAnchor).isActive = true
            } else {
                view.topAnchor.constraint(equalTo: menuItemViews[index - 1].bottomAnchor).isActive = true
            }
        }

        if let lastItem = menuItemViews.last {
            lastItem.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
}
