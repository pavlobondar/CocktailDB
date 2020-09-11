//
//  DrinksAndCategory.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

class DrinksAndCategory {
    let categoryName: String
    let drinks: [Drink]
    
    init(categoryName: String, drinks: [Drink]) {
        self.categoryName = categoryName
        self.drinks = drinks
    }
}
