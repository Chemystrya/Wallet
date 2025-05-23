//
//  CoinsListTableViewCell.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "cell"

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let coinNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .ebonyClay
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .ebonyClay
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let coinSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .manatee
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let changesPerDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .manatee
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.distribution = .fill
        stack.alignment = .trailing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 19
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let containerArrowStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .athensGray
        contentView.addSubview(contentStackView)

        containerArrowStack.addArrangedSubview(arrowImageView)
        containerArrowStack.addArrangedSubview(changesPerDayLabel)

        rightStackView.addArrangedSubview(priceLabel)
        rightStackView.addArrangedSubview(containerArrowStack)

        labelsStackView.addArrangedSubview(coinNameLabel)
        labelsStackView.addArrangedSubview(coinSymbolLabel)

        contentStackView.addArrangedSubview(iconImageView)
        contentStackView.addArrangedSubview(labelsStackView)
        contentStackView.addArrangedSubview(rightStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),

            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),

            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 12),

            rightStackView.widthAnchor.constraint(equalTo: labelsStackView.widthAnchor, multiplier: 0.8)
        ])
    }

    func configure(with coin: Coin) {
        iconImageView.image = UIImage(
            systemName: "bitcoinsign.circle.fill"
        )?.withTintColor(.pinkSalmon, renderingMode: .alwaysOriginal)
        coinNameLabel.text = coin.name
        coinSymbolLabel.text = coin.symbol.uppercased()
        priceLabel.text = formatNumber(coin.priceUsd, style: .currencyWithSymbols)

        let percentChange = coin.percentChangeUsdLast24Hours
        changesPerDayLabel.text = formatNumber(coin.percentChangeUsdLast24Hours, style: .percentWithDecimal)

        if percentChange >= 0 {
            arrowImageView.image = Image.arrowUpIcon.image
        } else {
            arrowImageView.image = Image.arrowDownIcon.image
        }
    }
}
