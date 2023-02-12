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
