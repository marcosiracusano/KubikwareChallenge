//
//  Restaurant.swift
//  KubikwareChallenge
//
//  Created by Marco Siracusano on 12/02/2023.
//

import Foundation

struct Restaurant: Decodable {
    var name: String?
    var uuid: String?
    var servesCuisine: String?
    var priceRange: Int?
    var currenciesAccepted: String?
    var address: Address?
    var aggregateRatings: [String: Rating]?
    var mainPhoto: Photo?
    var bestOffer: Offer?
}
