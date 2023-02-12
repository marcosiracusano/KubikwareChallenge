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

    // MARK: - Views
    
    lazy var nameLabel = ViewFactory.createLabel(size: 30, weight: .bold)
    lazy var ratingBadge = ViewFactory.createBadgeLabel(mainColor: .customDarkGreen, borderColor: .customDarkGreen)
    lazy var discountBadge = ViewFactory.createBadgeLabel(mainColor: .black, bgColor: .customYellow)
    lazy var cuisineBadge = ViewFactory.createBadgeLabel(mainColor: .white, bgColor: .customDarkGreen)
    lazy var locationLabel = ViewFactory.createLabel(size: 14, weight: .light)
    lazy var priceLabel = ViewFactory.createLabel(size: 14, weight: .medium)
    
    lazy var titleHStackView = ViewFactory.createHStackView(views: [nameLabel, favoritesButton], distribution: .equalSpacing)
    lazy var badgesHStackView = ViewFactory.createHStackView(views: [ratingBadge, discountBadge, cuisineBadge, UIView()])
    lazy var locationHStackView = ViewFactory.createHStackView(icon: "location", label: locationLabel)
    lazy var priceHStackView = ViewFactory.createHStackView(icon: "cash", label: priceLabel)
    
    lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "heart"), for: .normal)
        button.setImage(.init(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var mainPictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var mainPictureContainerView: UIView = {
        let containerView = UIView()
        containerView.applyShadows()
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(mainPictureImageView)
        return containerView
    }()
    
    lazy var mainVerticalStackView: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.alignment = .fill
        vStack.spacing = 16
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(titleHStackView)
        vStack.addArrangedSubview(badgesHStackView)
        vStack.addArrangedSubview(locationHStackView)
        vStack.addArrangedSubview(priceHStackView)
        vStack.addArrangedSubview(mainPictureContainerView)
        return vStack
    }()
    
    
    // MARK: - Properties
    
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
        
        contentView.addSubview(mainVerticalStackView)
        
        NSLayoutConstraint.activate([
            mainPictureImageView.topAnchor.constraint(equalTo: mainPictureContainerView.topAnchor),
            mainPictureImageView.bottomAnchor.constraint(equalTo: mainPictureContainerView.bottomAnchor),
            mainPictureImageView.leadingAnchor.constraint(equalTo: mainPictureContainerView.leadingAnchor),
            mainPictureImageView.trailingAnchor.constraint(equalTo: mainPictureContainerView.trailingAnchor),
            mainPictureImageView.heightAnchor.constraint(equalToConstant: 200),
            
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
