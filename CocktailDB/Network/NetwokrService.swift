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
    func loadData<T: Decodable>(target: APICocktailDB, completion: @escaping (Result<T, Error>) -> Void)
}

class NetwokrService: NetwokrServiceProtocol {
    let provider = MoyaProvider<APICocktailDB>()
    
    func loadData<T: Decodable>(target: APICocktailDB, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
