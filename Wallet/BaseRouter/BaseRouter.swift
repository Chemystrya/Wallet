//
//  BaseRouter.swift
//  Wallet
//
//  Created by Fedorova Maria on 23.05.2025.
//

import UIKit

protocol BaseRouter {
    func back()
}

final class BaseRouterImpl: BaseRouter {
    weak var transitionHandler: TransitionHandler?

    func back() {
        transitionHandler?.back(animated: true, completion: nil)
      }
}
