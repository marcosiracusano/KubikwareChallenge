//
//  RestaurantsViewModel.swift
//  KubikwareChallenge
//
//  Created by Marco Siracusano on 12/02/2023.
//

import Foundation
import Combine

class RestaurantsViewModel {
    
    enum Input {
        case viewDidLoad
        case refreshControlDidPull
        case favoriteButtonDidTap(isFavorite: Bool, uuid: String)
    }
    
    enum Output {
        case fetchRestaurantsDidFail(error: Error)
        case fetchRestaurantsDidSucceed
    }
    
    
    // MARK: - Properties
    
    private var restaurantsDataSource = [Restaurant]()
    
    private let service: RestaurantsServiceType
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    private let defaults = UserDefaults.standard
    
    
    // MARK: - Initializers
    
    init(service: RestaurantsServiceType = RestaurantsService()) {
        self.service = service
    }
    
    
    // MARK: - Main methods
    
    func getRestaurantsCount() -> Int {
        restaurantsDataSource.count
    }
    
    func getRestaurantUUID(for index: Int) -> String {
        let restaurant = restaurantsDataSource[index]
        return restaurant.uuid ?? ""
    }
    
    func getRestaurantName(for index: Int) -> String {
        let restaurant = restaurantsDataSource[index]
        return restaurant.name ?? "Name unavailable"
    }
    
    func isRestaurantFavorite(for index: Int) -> Bool {
        let restaurant = restaurantsDataSource[index]
        return defaults.bool(forKey: restaurant.uuid ?? "")
    }
    
    func getRestaurantRating(for index: Int) -> String {
        let restaurant = restaurantsDataSource[index]
        if let rating = restaurant.aggregateRatings?["thefork"]?.ratingValue {
            return String(rating)
        } else {
            return ""
        }
    }
    
    func getRestaurantDiscount(for index: Int) -> String {
        let restaurant = restaurantsDataSource[index]
        return restaurant.bestOffer?.label ?? ""
    }
    
    func getRestaurantCuisine(for index: Int) -> String {
        let restaurant = restaurantsDataSource[index]
        return restaurant.servesCuisine?.uppercased() ?? ""
    }
    
    func getRestaurantAddress(for index: Int) -> String {
        let restaurant = restaurantsDataSource[index]
        
        if let street = restaurant.address?.street,
           let locality = restaurant.address?.locality,
           let country = restaurant.address?.country {
            return street + ", " + locality + ", " + country
        } else {
            return "Address unavailable"
        }
    }
    
    func getAveragePriceRange(for index: Int) -> String {
        let restaurant = restaurantsDataSource[index]
        let currency = restaurant.currenciesAccepted ?? "eur"
        return restaurant.priceRange?.currencyFormattedString(currency) ?? "Price unavailable"
    }
    
    func getRestaurantImageUrl(for index: Int) -> URL? {
        let restaurant = restaurantsDataSource[index]
        return URL(string: restaurant.mainPhoto?.source ?? "")
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            
            switch event {
            case .viewDidLoad, .refreshControlDidPull:
                self?.handleFetchRestaurants()
                
            case .favoriteButtonDidTap(isFavorite: let isFavorite, uuid: let uuid):
                self?.defaults.setValue(isFavorite, forKey: uuid)
            }
        }
        .store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    
    // MARK: - Private methods
    
    private func handleFetchRestaurants() {
        service.fetchRestaurants()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.output.send(.fetchRestaurantsDidFail(error: error))
                }
            } receiveValue: { [weak self] restaurants in
                self?.restaurantsDataSource = restaurants
                self?.output.send(.fetchRestaurantsDidSucceed)
            }
            .store(in: &cancellables)
    }
}
