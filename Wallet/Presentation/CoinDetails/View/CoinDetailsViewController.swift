//
//  CoinDetailsViewController.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import UIKit

final class CoinDetailsViewController: UIViewController {
    private let viewModel: CoinDetailsViewModel

    private var currentInfoLabels: [UILabel] = []
    private var currentNumbersLabels: [UILabel] = []

    // MARK: - UIElements
    private let navigationView = NavigationView()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.medium.name, size: 28)
        label.textColor = .mirage
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let changesPerDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.medium.name, size: 14)
        label.textColor = .manatee
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let segmentedControl = CustomSegmentedControl(
        titles: [
            Localizable.CoinDetail.twentyFourHours,
            Localizable.CoinDetail.oneWeek,
            Localizable.CoinDetail.oneYear,
            Localizable.CoinDetail.all,
            Localizable.CoinDetail.point
        ]
    )

    private let marketStatisticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.medium.name, size: 20)
        label.textColor = .mirage
        label.text = Localizable.CoinDetail.marketStatistic
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let numbersStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .trailing
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(viewModel: CoinDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()

        segmentedControl.onValueChanged = { [weak self] index in
            self?.updateInfoForSegment(index: index)
            self?.updateNumbersForSegment(index: index)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .athensGray
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        let changePerDayAndArrowStack = UIStackView(arrangedSubviews: [arrowImageView, changesPerDayLabel])
        changePerDayAndArrowStack.axis = .horizontal
        changePerDayAndArrowStack.spacing = 5
        changePerDayAndArrowStack.alignment = .center
        changePerDayAndArrowStack.translatesAutoresizingMaskIntoConstraints = false

        let topStack = UIStackView(arrangedSubviews: [priceLabel, changePerDayAndArrowStack])
        topStack.axis = .vertical
        topStack.spacing = 0
        topStack.alignment = .center
        topStack.translatesAutoresizingMaskIntoConstraints = false

        let bottomStack = UIStackView(arrangedSubviews: [infoStackView, numbersStackView])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 40
        bottomStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(navigationView)
        view.addSubview(topStack)
        view.addSubview(segmentedControl)
        view.addSubview(infoContainerView)
        infoContainerView.addSubview(marketStatisticLabel)
        infoContainerView.addSubview(bottomStack)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        navigationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            arrowImageView.heightAnchor.constraint(equalToConstant: 12),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),

            topStack.topAnchor.constraint(equalTo: navigationView.bottomAnchor,constant: 5),
            topStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            segmentedControl.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            segmentedControl.heightAnchor.constraint(equalToConstant: 56),

            infoContainerView.topAnchor.constraint(greaterThanOrEqualTo: segmentedControl.bottomAnchor, constant: 16),
            infoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoContainerView.heightAnchor.constraint(equalToConstant: 242),

            marketStatisticLabel.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 25),
            marketStatisticLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 25),
            marketStatisticLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -25),

            bottomStack.topAnchor.constraint(equalTo: marketStatisticLabel.bottomAnchor, constant: 15),
            bottomStack.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 25),
            bottomStack.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -25),
        ])
    }

    // MARK: - Configure
    private func configure() {
        navigationView.configure(
            viewModel: NavigationViewModel(
                title: "\(viewModel.coinDetails.name) (\(viewModel.coinDetails.symbol.uppercased()))",
                backgroundColor: .clear,
                leftButtonAction: { [weak self] in
                    self?.viewModel.back()
                },
                rightButtonAction: { [weak self] in
                    self?.viewModel.logout()
                }
            )
        )
        priceLabel.text = formatNumber(viewModel.coinDetails.priceUsd, style: .currencyWithSymbols)

        let percentChange = viewModel.coinDetails.percentChangeUsdLast24Hours
        changesPerDayLabel.text = formatNumber(viewModel.coinDetails.percentChangeUsdLast24Hours, style: .percentWithDecimal)

        if percentChange >= 0 {
            arrowImageView.image = Image.arrowUpIcon.image
        } else {
            arrowImageView.image = Image.arrowDownIcon.image
        }

        updateInfoForSegment(index: 0)
        updateNumbersForSegment(index: 0)
    }

    // MARK: - Segment Control Action
    private func updateInfoForSegment(index: Int) {
        currentInfoLabels.forEach { $0.removeFromSuperview() }
        currentInfoLabels.removeAll()

        let info: [String]
        switch index {
        case 0:
            info = [
                Localizable.CoinDetail.marketCapitalization,
                Localizable.CoinDetail.circulatingSuply
            ]
        case 1:
            info = [
                Localizable.CoinDetail.changelastOneWeek,
                Localizable.CoinDetail.changeBtcLastOneWeek
            ]
        case 2:
            info = [
                Localizable.CoinDetail.changeLastOneYear,
                Localizable.CoinDetail.changeBtcLastOneYear
            ]
        case 3:
            info = [
                Localizable.CoinDetail.price,
                Localizable.CoinDetail.percentDown
            ]
        case 4:
            info = [
                Localizable.CoinDetail.stars,
                Localizable.CoinDetail.watchers
            ]
        default:
            info = []
        }

        let labels = info.map { text -> UILabel in
            let label = UILabel()
            label.text = text
            label.font = UIFont(name: Font.medium.name, size: 14)
            label.textColor = .manatee
            label.textAlignment = .center
            return label
        }

        currentInfoLabels = labels
        labels.forEach { infoStackView.addArrangedSubview($0) }
    }

    private func updateNumbersForSegment(index: Int) {
        currentNumbersLabels.forEach { $0.removeFromSuperview() }
        currentNumbersLabels.removeAll()
        let numbers: [String?]
        switch index {
        case 0:
            numbers = [
                formatNumber(viewModel.coinDetails.currentMarketcapUsd, style: .currencyWithSymbols),
                formatNumber(viewModel.coinDetails.circulating, style: .percentWithDecimal)
            ]
        case 1:
            numbers = [
                formatNumber(viewModel.coinDetails.percentChangeLast1Week, style: .percentWithDecimal),
                formatNumber(viewModel.coinDetails.percentChangeBtcLast1Week, style: .percentWithDecimal)
            ]
        case 2:
            numbers = [
                formatNumber(viewModel.coinDetails.percentChangeLast1Year, style: .percentWithDecimal),
                formatNumber(viewModel.coinDetails.percentChangeBtcLast1Year, style: .percentWithDecimal)
            ]
        case 3:
            numbers = [
                formatNumber(viewModel.coinDetails.price, style: .currencyWithSymbols),
                formatNumber(viewModel.coinDetails.percentDown, style: .percentWithDecimal)
            ]
        case 4:
            numbers = [
                "\(viewModel.coinDetails.stars)",
                "\(viewModel.coinDetails.watchers)"
            ]
        default:
            numbers = []
        }

        let labels = numbers.map { text -> UILabel in
            let label = UILabel()
            label.text = text
            label.font = UIFont(name: Font.semiBold.name, size: 14)
            label.textColor = .mirage
            label.textAlignment = .center
            return label
        }

        currentNumbersLabels = labels
        labels.forEach { numbersStackView.addArrangedSubview($0) }
    }
}

// MARK: - Gesture Recognizer Delegate
extension CoinDetailsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == navigationController?.interactivePopGestureRecognizer {
            return true
        }

        return true
    }
}
