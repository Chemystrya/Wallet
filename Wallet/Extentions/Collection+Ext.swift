//
//  Collection+Ext.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

