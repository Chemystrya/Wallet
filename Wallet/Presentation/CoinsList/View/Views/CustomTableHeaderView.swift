//
//  CustomTableHeaderView.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//
import UIKit

final class CustomTableHeaderView: UIView {
    private var dropdown: CustomDropdownMenu?
    private var blurBackgroundView: UIView?

    // MARK: - UIElements
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.text = Localizable.CoinsList.home
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ellipsisButton: UIButton = {
        let button = UIButton()
        button.setImage(
            Image.ellipsisIcon.image?.withRenderingMode(.alwaysOriginal).resized(to: CGSize(width: 24, height: 24)),
            for: .normal
        )
        button.backgroundColor = .white
        button.alpha = 0.8
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addAction(UIAction { [weak self] _ in
            self?.showCustomDropdown()
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .pinkSalmon
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let affiliateProgramLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = Localizable.CoinsList.affiliateProgram
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let learnMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localizable.CoinsList.learnMore, for: .normal)
        button.setTitleColor(.ebonyClay, for: .normal)
        button.layer.cornerRadius = 18
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .blackHaze
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let coinsListStackImage: UIImageView = {
        let image = UIImageView()
        image.image = Image.coinsListStack.image
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let shadowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shadowForCoinsListStack")
        image.clipsToBounds = false
        image.layer.zPosition = -1
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var onUpdateTapAction: (() -> Void)?
    private var onLogoutTapAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup
    private func setupUI() {
        let affiliateAndLearnMoreStack = UIStackView(arrangedSubviews: [affiliateProgramLabel, learnMoreButton])
        affiliateAndLearnMoreStack.axis = .vertical
        affiliateAndLearnMoreStack.spacing = 12
        affiliateAndLearnMoreStack.alignment = .leading
        affiliateAndLearnMoreStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundView)
        backgroundView.addSubview(homeLabel)
        backgroundView.addSubview(ellipsisButton)
        backgroundView.addSubview(affiliateAndLearnMoreStack)
        backgroundView.addSubview(shadowImage)
        backgroundView.addSubview(coinsListStackImage)

        NSLayoutConstraint.activate(
            [
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 42),
                
                homeLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 64),
                homeLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25),
                
                ellipsisButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 64),
                ellipsisButton.leadingAnchor.constraint(greaterThanOrEqualTo: homeLabel.trailingAnchor, constant: 180),
                ellipsisButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25),
                ellipsisButton.heightAnchor.constraint(equalToConstant: 48),
                ellipsisButton.widthAnchor.constraint(equalToConstant: 48),
                
                affiliateAndLearnMoreStack.topAnchor.constraint(equalTo: homeLabel.bottomAnchor, constant: 46),
                affiliateAndLearnMoreStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25),
                affiliateAndLearnMoreStack.widthAnchor.constraint(equalToConstant: 172),
                
                learnMoreButton.widthAnchor.constraint(equalToConstant: 127),
                learnMoreButton.heightAnchor.constraint(equalToConstant: 35),
                
                coinsListStackImage.topAnchor.constraint(equalTo: ellipsisButton.bottomAnchor, constant: 16),
                coinsListStackImage.leadingAnchor.constraint(greaterThanOrEqualTo: affiliateAndLearnMoreStack.trailingAnchor),
                coinsListStackImage.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
                coinsListStackImage.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 40),
                coinsListStackImage.widthAnchor.constraint(equalToConstant: 242),
                coinsListStackImage.heightAnchor.constraint(equalToConstant: 242),

                shadowImage.leadingAnchor.constraint(equalTo: coinsListStackImage.leadingAnchor, constant: -100),
                shadowImage.bottomAnchor.constraint(equalTo: coinsListStackImage.bottomAnchor),
                shadowImage.trailingAnchor.constraint(equalTo: coinsListStackImage.trailingAnchor),
                shadowImage.heightAnchor.constraint(equalToConstant: 185)
            ]
        )
    }

    @objc private func dismissDropdown() {
        guard let dropdownMenu = dropdown, let dimView = blurBackgroundView else { return }

        UIView.animate(withDuration: 0.3, animations: {
            dimView.alpha = 0
            dropdownMenu.alpha = 0
        }, completion: { _ in
            dropdownMenu.removeFromSuperview()
            dimView.removeFromSuperview()
            self.dropdown = nil
            self.blurBackgroundView = nil
        })
    }

    private func refreshTable() {
        onUpdateTapAction?()
        print("Выполняется обновление таблицы...")
    }

    private func logoutUser() {
        onLogoutTapAction?()
        print("Выход пользователя.")
    }

    private func showCustomDropdown() {
        guard dropdown == nil else { return }

        let dimView = UIView()
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimView.alpha = 0
        dimView.frame = backgroundView.bounds
        dimView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(dimView)
        self.blurBackgroundView = dimView

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissDropdown))
        dimView.addGestureRecognizer(tap)

        UIView.animate(withDuration: 0.3) {
            dimView.alpha = 1
        }

        let dropdownMenu = CustomDropdownMenu()
        dropdownMenu.onItemSelected = { [weak self] selectedItem in
            print("Выбрано: $selectedItem)")

            switch selectedItem {
            case "Обновить":
                self?.refreshTable()
            case "Выйти":
                self?.logoutUser()
            default:
                break
            }

            self?.dismissDropdown()
        }

        dropdownMenu.alpha = 0
        dropdownMenu.setupButtons(items: [
            ("rocketIcon", Localizable.CoinsList.update),
            ("garbageIcon", Localizable.CoinsList.goOut)
        ])
        dropdownMenu.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(dropdownMenu)

        NSLayoutConstraint.activate([
            dropdownMenu.widthAnchor.constraint(equalToConstant: 157),
            dropdownMenu.heightAnchor.constraint(equalToConstant: 102),
            dropdownMenu.topAnchor.constraint(equalTo: ellipsisButton.bottomAnchor, constant: 8),
            dropdownMenu.trailingAnchor.constraint(equalTo: ellipsisButton.trailingAnchor)
        ])

        self.dropdown = dropdownMenu

        UIView.animate(withDuration: 0.3) {
            dropdownMenu.alpha = 1
        }
    }

    func setupActions(updateAction: (() -> Void)?, logoutAction: (() -> Void)?) {
        onUpdateTapAction = updateAction
        onLogoutTapAction = logoutAction
    }
}
