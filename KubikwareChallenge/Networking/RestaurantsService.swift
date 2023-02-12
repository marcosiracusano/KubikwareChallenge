//
//  RestaurantsService.swift
//  KubikwareChallenge
//
//  Created by Marco Siracusano on 12/02/2023.
//

import Foundation
import Combine

protocol RestaurantsServiceType {
    func fetchRestaurants() -> AnyPublisher <[Restaurant], Error>
}

class RestaurantsService: RestaurantsServiceType {
    
    func fetchRestaurants() -> AnyPublisher <[Restaurant], Error> {
        let url = URL(string: "https://alanflament.github.io/TFTest/test.json")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .map({ $0.data })
            .decode(type: [String:[Restaurant]].self, decoder: JSONDecoder())
            .map({ $0["data"] ?? [] })
            .eraseToAnyPublisher()
    }
}
