//
//  Request.swift
//  Wallet
//
//  Created by Fedorova Maria on 21.05.2025.
//

import Foundation

protocol Request {
    associatedtype ResponseType: Decodable

    var url: URL? { get }
}
