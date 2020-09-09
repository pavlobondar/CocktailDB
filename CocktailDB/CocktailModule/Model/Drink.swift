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
    let imageURL: URL?
}

extension Drink: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = URL(string: try container.decode(String.self, forKey: .imageURL))
    }
}
