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
    case category(name: String)
}

extension APICocktailDB: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://www.thecocktaildb.com") else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .category(name: _):
            return "/api/json/v1/1/filter.php"
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
        case .category(let name):
            return .requestParameters(parameters: ["c" : name], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
