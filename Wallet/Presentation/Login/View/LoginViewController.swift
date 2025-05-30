//
//  LoginViewController.swift
//  Wallet
//
//  Created by Fedorova Maria on 19.05.2025.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - UIElements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .athensGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        image: Image.usernameIcon.image,
        isSecureTextEntry: false
    )
    private lazy var passwordTextField = makeTextField(
        placeholder: Localizable.Login.password,
        image: Image.passwordIcon.image,
        isSecureTextEntry: true
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
        button.titleLabel?.font = UIFont(name: Font.semiBold.name, size: 15)
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
        registerForKeyboardNotifications()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(tap)

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        usernameView.layer.cornerRadius = usernameView.frame.height / 2
        passwordView.layer.cornerRadius = passwordView.frame.height / 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }

    deinit {
        removeKeyBoardNotifications()
    }

    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .athensGray

        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(loginImage)
        containerView.addSubview(usernameView)
        containerView.addSubview(passwordView)
        containerView.addSubview(loginButton)

        usernameView.addSubview(usernameTextField)
        passwordView.addSubview(passwordTextField)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            loginImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            loginImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 44),
            loginImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -44),
            loginImage.heightAnchor.constraint(equalToConstant: 287),

            usernameView.topAnchor.constraint(greaterThanOrEqualTo: loginImage.bottomAnchor, constant: 24),
            usernameView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            usernameView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
            usernameView.heightAnchor.constraint(equalToConstant: 55),

            passwordView.topAnchor.constraint(equalTo: usernameView.bottomAnchor, constant: 15),
            passwordView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            passwordView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
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
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
            loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -133),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
        ])

        updateLoginButtonState()
        view.layoutIfNeeded()
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

    // MARK: - Keyboard Notifications
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }

        let keyboardHeight = keyboardFrame.height
        scrollView.setContentOffset(CGPoint(x: 0, y: keyboardHeight / 2), animated: true)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    private func removeKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
    private func makeTextField(placeholder: String, image: UIImage?, isSecureTextEntry: Bool) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.keyboardType = .asciiCapable
        textField.isSecureTextEntry = isSecureTextEntry
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self

        let leftContainer = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 32))
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)

        leftContainer.addSubview(imageView)
        textField.leftView = leftContainer
        textField.leftViewMode = .always

        return textField
    }

    // MARK: - Alert Actions
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

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
