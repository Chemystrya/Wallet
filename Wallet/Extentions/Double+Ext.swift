//
//  Double+Ext.swift
//  Wallet
//
//  Created by Fedorova Maria on 23.05.2025.
//

import Foundation

enum NumberFormatStyle {
    case percentWithDecimal   // Например: 12.34%
    case currencyWithSymbols  // Например: $12,345.67
}

func formatNumber(_ value: Double, style: NumberFormatStyle) -> String? {
    let formatter = NumberFormatter()

    switch style {
    case .percentWithDecimal:
        formatter.numberStyle = .none
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = false
        return "\(formatter.string(from: NSNumber(value: value)) ?? "")%"

    case .currencyWithSymbols:
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.currencySymbol = "$"
        formatter.positiveFormat = "$#,##0.00"
        formatter.negativeFormat = "-$#,##0.00"
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(value: value))
    }
}
