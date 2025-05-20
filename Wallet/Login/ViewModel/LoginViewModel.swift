//
//  LoginViewModel.swift
//  Wallet
//
//  Created by Fedorova Maria on 20.05.2025.
//

protocol LoginViewModelProtocol: AnyObject {
    var isFormValid: Bool { get }

    func setUsername(_ username: String)
    func setPassword(_ password: String)
    func login(completion: @escaping (Bool) -> Void)
    func setFormValidationHandler(_ handler: (() -> Void)?)
    func openHomeScreen()
}

final class LoginViewModel: LoginViewModelProtocol {
    private let service: LoginService
    private let router: LoginRouter

    private var formValidationHandler: (() -> Void)?
    private var username: String = ""
    private var password: String = ""

    var isFormValid: Bool = false {
        didSet {
            formValidationHandler?()
        }
    }

    init(service: LoginService, router: LoginRouter) {
        self.service = service
        self.router = router
    }

    func setFormValidationHandler(_ handler: (() -> Void)?) {
        self.formValidationHandler = handler
    }

    func setUsername(_ username: String) {
        self.username = username
        validateForm()
    }

    func setPassword(_ password: String) {
        self.password = password
        validateForm()
    }

    func login(completion: @escaping (Bool) -> Void) {
        service.login(username: username, password: password, completion: completion)
    }

    func openHomeScreen() {
        router.openHomeScreen()
    }
}

// MARK: - Private Methods
private extension LoginViewModel {
    func validateForm() {
        isFormValid = service.validate(username: username, password: password)
    }
}
