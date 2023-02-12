//
//  MockRestaurantsService.swift
//  KubikwareChallengeTests
//
//  Created by Marco Siracusano on 12/02/2023.
//

import Foundation
import Combine
@testable import KubikwareChallenge

class MockRestaurantsService: RestaurantsServiceType {
    
    var fetchRestaurantsResult: AnyPublisher<[KubikwareChallenge.Restaurant], Error>!
    func fetchRestaurants() -> AnyPublisher<[KubikwareChallenge.Restaurant], Error> {
        if let fetchRestaurantsResult {
            return fetchRestaurantsResult
        } else {
            return getSuccessResult()
        }
    }
    
    func getSuccessResult(_ restaurant: Restaurant = MockFactory.exampleRestaurant, quantity: Int = 9) -> AnyPublisher<[KubikwareChallenge.Restaurant], Error> {
        let result = MockFactory.createRestaurantArray(restaurant, quantity: quantity)
        return Result.success(result).publisher.eraseToAnyPublisher()
    }
    
    func getFailureResult(with error: Error = NSError()) -> AnyPublisher<[KubikwareChallenge.Restaurant], Error> {
        Result.failure(error).publisher.eraseToAnyPublisher()
    }
}
