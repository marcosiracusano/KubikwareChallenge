//
//  Address.swift
//  KubikwareChallenge
//
//  Created by Marco Siracusano on 12/02/2023.
//

import Foundation

struct Address: Decodable {
    var street: String?
    var postalCode: String?
    var locality: String?
    var country: String?
}
