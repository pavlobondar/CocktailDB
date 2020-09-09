//
//  NetwokrService.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
import Moya

protocol NetwokrServiceProtocol {
    func fetchCocktailList(target: APICocktailDB, completion: @escaping (Result<[Drink], Error>) -> Void)
}

class NetwokrService: NetwokrServiceProtocol {
    typealias Handler = (Result<[Drink], Error>) -> Void
    let provider = MoyaProvider<APICocktailDB>()
    
    func fetchCocktailList(target: APICocktailDB, completion: @escaping Handler) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(DrinksList.self, from: response.data)
                    completion(.success(results.drinks))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
