//
//  MockRestaurantsViewModel.swift
//  KubikwareChallengeTests
//
//  Created by Marco Siracusano on 12/02/2023.
//

import Foundation
@testable import KubikwareChallenge

class MockRestaurantsViewModel: RestaurantsViewModel {
    
    var _getRestaurantsCount = 0
    override func getRestaurantsCount() -> Int {
        _getRestaurantsCount
    }
    
    var _getRestaurantName = ""
    override func getRestaurantName(for index: Int) -> String {
        _getRestaurantName
    }
    
    var _getRestaurantRating = ""
    override func getRestaurantRating(for index: Int) -> String {
        _getRestaurantRating
    }
    
    var _getRestaurantAddress = ""
    override func getRestaurantAddress(for index: Int) -> String {
        _getRestaurantAddress
    }
    
    var _getAveragePriceRange = ""
    override func getAveragePriceRange(for index: Int) -> String {
        _getAveragePriceRange
    }
    
    var _getRestaurantCuisine = ""
    override func getRestaurantCuisine(for index: Int) -> String {
        _getRestaurantCuisine
    }
    
    var _getRestaurantDiscount = ""
    override func getRestaurantDiscount(for index: Int) -> String {
        _getRestaurantDiscount
    }
    
    var _getRestaurantUUID = ""
    override func getRestaurantUUID(for index: Int) -> String {
        _getRestaurantUUID
    }
    
    var _getRestaurantImageUrl: URL? = nil
    override func getRestaurantImageUrl(for index: Int) -> URL? {
        _getRestaurantImageUrl
    }
    
    var _isRestaurantFavorite = false
    override func isRestaurantFavorite(for index: Int) -> Bool {
        _isRestaurantFavorite
    }
}
