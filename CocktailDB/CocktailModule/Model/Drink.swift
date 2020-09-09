//
//  Drink.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

struct Drink {
    let id: String
    let name: String
    let image: String
}

extension Drink: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case image = "strDrinkThumb"
    }
}
