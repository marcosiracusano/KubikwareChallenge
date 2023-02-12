//
//  ViewFactory.swift
//  KubikwareChallenge
//
//  Created by Marco Siracusano on 12/02/2023.
//

import UIKit

struct ViewFactory {
    
    static func createLabel(size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: size, weight: weight)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createBadgeLabel(mainColor: UIColor, bgColor: UIColor = .clear, borderColor: UIColor = .clear) -> UILabel {
        let label = PaddingLabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = mainColor
        label.backgroundColor = bgColor
        label.layer.borderColor = borderColor.cgColor
        label.layer.borderWidth  = 2
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createRatingBadge() -> UILabel {
        let label = PaddingLabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .customDarkGreen
        label.layer.borderColor = UIColor.customDarkGreen.cgColor
        label.layer.borderWidth  = 1
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createHStackView(views: [UIView], distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = distribution
        hStack.alignment = .center
        hStack.spacing = 12
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        for view in views {
            hStack.addArrangedSubview(view)
        }
        
        return hStack
    }
    
    static func createHStackView(icon: String, label: UILabel) -> UIStackView {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.alignment = .center
        hStack.spacing = 8
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UIImage(named: icon) {
            let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            hStack.addArrangedSubview(imageView)
        }
        
        hStack.addArrangedSubview(label)
        hStack.addArrangedSubview(UIView())
        
        return hStack
    }
}

class PaddingLabel: UILabel {
    var textEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8) {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
}
