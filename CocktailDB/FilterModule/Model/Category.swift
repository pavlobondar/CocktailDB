//
//  Category.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

struct Category {
    let category: String
}

extension Category: Decodable {
    enum CodingKeys: String, CodingKey {
        case category = "strCategory"
    }
}
