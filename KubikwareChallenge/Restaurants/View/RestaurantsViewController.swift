//
//  RestaurantsViewController.swift
//  KubikwareChallenge
//
//  Created by Marco Siracusano on 12/02/2023.
//

import UIKit
import Combine
import Kingfisher

class RestaurantsViewController: UIViewController {

    // MARK: - Properties
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .heavy)
        label.text = "Restaurants"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var viewModel: RestaurantsViewModel = .init()
    private let input: PassthroughSubject<RestaurantsViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        bind()
        input.send(.viewDidLoad)
    }
    

    // MARK: - Private methods
    
    private func setupView() {
        view.addSubview(nameLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            nameLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .fetchRestaurantsDidFail(error: let error):
                    print("Networking Error: \(error)")
                    
                case .fetchRestaurantsDidSucceed:
                    self?.tableView.refreshControl?.endRefreshing()
                    self?.tableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
    @objc private func pullToRefresh() {
        input.send(.refreshControlDidPull)
    }
}


// MARK: - Extensions

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getRestaurantsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as? RestaurantTableViewCell
                
        if let cell {
            cell.favoritesDelegate = self
            cell.uuid = viewModel.getRestaurantUUID(for: indexPath.row)
            cell.isFavorite = viewModel.isRestaurantFavorite(for: indexPath.row)
            cell.nameLabel.text = viewModel.getRestaurantName(for: indexPath.row)
            cell.locationLabel.text = viewModel.getRestaurantAddress(for: indexPath.row)
            cell.priceLabel.text = viewModel.getAveragePriceRange(for: indexPath.row)
            
            cell.mainPictureImageView.kf.setImage(with: viewModel.getRestaurantImageUrl(for: indexPath.row),
                                                  placeholder: UIImage(named: "placeholder"))
        }
        
        return cell ?? UITableViewCell()
    }
}

extension RestaurantsViewController: RestaurantTableViewCellFavoriteDelegate {
    func favoriteButtonDidTap(isFavorite: Bool, id: String) {
        input.send(.favoriteButtonDidTap(isFavorite: isFavorite, uuid: id))
    }
}
