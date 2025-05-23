//
//  LoginViewController.swift
//  Wallet
//
//  Created by Fedorova Maria on 19.05.2025.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - UIElements
    private let loginImage: UIImageView = {
        let image = UIImageView()
        image.image = Image.loginRobot.image
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var usernameTextField = makeTextField(
        placeholder: Localizable.Login.username,
        image: Image.usernameIcon.image
    )
    private lazy var passwordTextField = makeTextField(
        placeholder: Localizable.Login.password,
        image: Image.passwordIcon.image
    )

    private let usernameView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(Localizable.Login.login, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = .mirage
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { [weak self] _ in self?.loginTapped() }, for: .touchUpInside)
        return button
    }()

    // MARK: - Properties & Init
    private let viewModel: LoginViewModelProtocol
    private var didSetupBinding = false

    init(viewModel: LoginViewModelProtocol) {
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
        bindViewModel()

        usernameTextField.addAction(
            UIAction { [weak self] _ in
                self?.viewModel.setUsername(self?.usernameTextField.text ?? "")
            },
            for: .editingChanged
        )

        passwordTextField.addAction(
            UIAction { [weak self] _ in
                self?.viewModel.setPassword(self?.passwordTextField.text ?? "")
            },
            for: .editingChanged
        )
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        usernameView.layer.cornerRadius = usernameView.frame.height / 2
        passwordView.layer.cornerRadius = passwordView.frame.height / 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .athensGray

        view.addSubview(loginImage)
        view.addSubview(usernameView)
        view.addSubview(passwordView)
        view.addSubview(loginButton)

        usernameView.addSubview(usernameTextField)
        passwordView.addSubview(passwordTextField)

        NSLayoutConstraint.activate([
            loginImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            loginImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            loginImage.heightAnchor.constraint(equalToConstant: 287),

            usernameView.topAnchor.constraint(greaterThanOrEqualTo: loginImage.bottomAnchor, constant: 16),
            usernameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            usernameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            usernameView.heightAnchor.constraint(equalToConstant: 55),

            passwordView.topAnchor.constraint(equalTo: usernameView.bottomAnchor, constant: 15),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            passwordView.heightAnchor.constraint(equalToConstant: 55),

            usernameTextField.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor, constant: 10),
            usernameTextField.topAnchor.constraint(equalTo: usernameView.topAnchor),
            usernameTextField.bottomAnchor.constraint(equalTo: usernameView.bottomAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor),

            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 10),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 25),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133)

        ])

        updateLoginButtonState()
    }

    private func bindViewModel() {
        viewModel.setFormValidationHandler { [weak self] in
            self?.updateLoginButtonState()
        }
    }

    private func updateLoginButtonState() {
        loginButton.backgroundColor = viewModel.isFormValid ? .mirage : .systemGray
        loginButton.isUserInteractionEnabled = viewModel.isFormValid
    }

    // MARK: - TextField Actions
    private func loginTapped() {
        viewModel.login { [weak self] success in
            if success {
                self?.viewModel.openHomeScreen()
            } else {
                self?.showInvalidLoginAlert()
            }
        }
    }

    // MARK: - makeTextField 
    private func makeTextField(placeholder: String, image: UIImage?) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false

        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 32))
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)

        leftContainer.addSubview(imageView)
        textField.leftView = leftContainer
        textField.leftViewMode = .always

        return textField
    }

    // MARK: - Actions
    private func showInvalidLoginAlert() {
        let alert = UIAlertController(
            title: Localizable.Error.error,
            message: Localizable.Error.incorrectLoginOrPassword,
            preferredStyle: .alert
        )

        let retryAction = UIAlertAction(title: Localizable.Error.repeatAgain, style: .default) { _ in }

        let cancelAction = UIAlertAction(title: Localizable.Error.cancel, style: .cancel) { [weak self] _ in
            self?.usernameTextField.text = ""
            self?.passwordTextField.text = ""
        }

        alert.addAction(retryAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}
