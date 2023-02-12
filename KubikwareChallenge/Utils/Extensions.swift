//
//  Extensions.swift
//  KubikwareChallenge
//
//  Created by Marco Siracusano on 12/02/2023.
//

import UIKit

extension UIView {
    func applyShadows() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

extension Int {
    func currencyFormattedString(_ currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: self)
        
        return formatter.string(from: number) ?? "€--"
    }
}
