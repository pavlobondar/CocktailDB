//
//  APICocktailDB.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
import Moya

enum APICocktailDB {
    case cocktail(name: String)
    case categories
}

extension APICocktailDB: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://www.thecocktaildb.com") else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .cocktail(_):
            return "/api/json/v1/1/filter.php"
        case .categories:
            return "/api/json/v1/1/list.php"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .cocktail(let name):
            return .requestParameters(parameters: ["c" : name], encoding: URLEncoding.default)
        case .categories:
            return .requestParameters(parameters: ["c" : "list"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
