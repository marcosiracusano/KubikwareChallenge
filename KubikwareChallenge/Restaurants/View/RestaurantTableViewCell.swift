//
//  RestaurantTableViewCell.swift
//  KubikwareChallenge
//
//  Created by Marco Siracusano on 12/02/2023.
//

import UIKit

protocol RestaurantTableViewCellFavoriteDelegate {
    func favoriteButtonDidTap(isFavorite: Bool, id: String)
}

class RestaurantTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "heart"), for: .normal)
        button.setImage(.init(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    lazy var mainVerticalStackView: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.alignment = .fill
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    static let identifier = String(describing: RestaurantTableViewCell.self)
    
    var favoritesDelegate: RestaurantTableViewCellFavoriteDelegate!
    var uuid: String!
    var isFavorite: Bool! {
        didSet {
            favoritesButton.isSelected = isFavorite
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        horizontalStackView.addArrangedSubview(nameLabel)
        horizontalStackView.addArrangedSubview(favoritesButton)
        
        mainVerticalStackView.addArrangedSubview(horizontalStackView)
        
        contentView.addSubview(mainVerticalStackView)
        
        NSLayoutConstraint.activate([
            mainVerticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private methods
    
    @objc private func favoritesButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        favoritesDelegate.favoriteButtonDidTap(isFavorite: sender.isSelected, id: uuid)
    }
}
