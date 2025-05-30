//
//  Colors.swift
//  Wallet
//
//  Created by Fedorova Maria on 19.05.2025.
//

import UIKit

extension UIColor {
    public convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff

        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff,
            alpha: 1
        )
    }
}

extension UIColor {
    static let athensGray = UIColor(hex: "0xF7F7FA")
    static let mirage = UIColor(hex: "0x191C32")
    static let pinkSalmon = UIColor(hex: "0xFF9AB2")
    static let ebonyClay = UIColor(hex: "0x26273C")
    static let blackHaze = UIColor(hex: "0xFAFBFB")
    static let manatee = UIColor(hex: "0x9395A4")
    static let porcelain = UIColor(hex: "0xEBEFF1")
    static let mischka = UIColor(hex: "0xCED0DE")
}
