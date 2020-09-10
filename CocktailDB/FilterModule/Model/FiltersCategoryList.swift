//
//  FiltersCategoryList.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

struct FiltersCategoryList {
    let categories: [Category]
}

extension FiltersCategoryList: Decodable {
    enum CodingKeys: String, CodingKey {
        case categories = "drinks"
    }
}
