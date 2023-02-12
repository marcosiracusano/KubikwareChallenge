//
//  MockFactory.swift
//  KubikwareChallengeTests
//
//  Created by Marco Siracusano on 12/02/2023.
//

import Foundation
@testable import KubikwareChallenge

class MockFactory {
    
    static let exampleRestaurant = Restaurant(name:  "Curry Garden",
                                              uuid: "4eg4e2bn-1080-4e1e-8438-6t90ht123456",
                                              servesCuisine: "Indian",
                                              priceRange: 25,
                                              currenciesAccepted: "EUR",
                                              address: Address(street:  "89 Rue de Bagnolet",
                                                               postalCode: "75020",
                                                               locality: "Paris",
                                                               country: "France"),
                                              aggregateRatings: ["thefork": Rating(ratingValue: 9.5,
                                                                                   reviewCount: 275)],
                                              mainPhoto: Photo(source: "https://res.cloudinary.com/tf-lab/image/upload/restaurant/b1d8f006-2477-4715-b937-2c34d616dccb/68e364a6-e903-4fb1-9e1e-d91d97457266.jpg"),
                                              bestOffer: Offer(name: "40% off the 'a la carte' menu",
                                                               label: "-40%"))
    
    static func createRestaurantArray(_ restaurant: Restaurant, quantity: Int) -> [Restaurant] {
        Array(repeating: restaurant, count: quantity).compactMap {$0}
    }
}
