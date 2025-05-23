//
//  CoinsListViewController.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

import UIKit

final class CoinsListViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let viewModel: CoinsListViewModel
    private let headerView = CustomTableHeaderView()

    init(viewModel: CoinsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        loadCoinsFromServer()
        setupHeaderActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func setupTableView() {
        view.addSubview(headerView)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .athensGray
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 40
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.clipsToBounds = true
        tableView.layer.zPosition = 1
        tableView.register(CoinsListTableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    //    MARK: - Private

    private func setupHeaderActions() {
        headerView.setupActions(
            updateAction: { [weak self] in
                self?.loadCoinsFromServer()
            },
            logoutAction: { [weak self] in
                self?.viewModel.logout()
            }
        )
    }

    private func setupActivityIndicator() {
        activityIndicator.color = .gray
        activityIndicator.layer.zPosition = 1
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 130)
        ])
    }

    private func loadCoinsFromServer() {
        activityIndicator.startAnimating()

        viewModel.fetchCoins {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }

                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }

    private func makeSortMenu() -> UIMenu {
        let sortAscending = UIAction(title: SortType.priceAsc.title) { _ in
            self.viewModel.setSortType(.priceAsc)
            self.tableView.reloadData()
        }

        let sortDescending = UIAction(title: SortType.priceDesc.title) { _ in
            self.viewModel.setSortType(.priceDesc)
            self.tableView.reloadData()
        }
        let menu = UIMenu(title: Localizable.CoinsList.sortingPrinciple, children: [sortAscending, sortDescending])

        return menu
    }
}
// MARK: - TableView DataSource
extension CoinsListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CoinsListTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CoinsListTableViewCell else {
            return UITableViewCell()
        }
        let coin = viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
}
// MARK: - TableView Delegate
extension CoinsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.openCoinDetailScreen(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .athensGray

        let label = UILabel()
        label.backgroundColor = .clear
        label.text = Localizable.CoinsList.trending
        label.font = UIFont(name: Font.medium.name, size: 20)
        label.textColor = .mirage
        label.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton()
        button.setImage(Image.sortButtonIcon.image, for: .normal)
        button.menu = makeSortMenu()
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(label)
        headerView.addSubview(button)

        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 35),

            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 25),
            label.trailingAnchor.constraint(lessThanOrEqualTo: button.leadingAnchor, constant: -8),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            button.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -25),
            button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])

        return headerView
    }
}
