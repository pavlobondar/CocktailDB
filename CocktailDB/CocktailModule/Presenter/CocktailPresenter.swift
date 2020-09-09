//
//  CocktailPresenter.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol CocktailViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol CocktailViewPresenterProtocol: class {
    init(view: CocktailViewProtocol, networkService: NetwokrServiceProtocol, router: RouterProtocol)
    func fetchDrinks()
    func goToTheFilterView()
    var drinks: [Drink]? { get set }
}

class CocktailPresenter: CocktailViewPresenterProtocol {
    weak var view: CocktailViewProtocol?
    var router: RouterProtocol?
    let networkService: NetwokrServiceProtocol!
    var drinks: [Drink]?
    
    required init(view: CocktailViewProtocol, networkService: NetwokrServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        fetchDrinks()
    }
    
    func fetchDrinks() {
        networkService.fetchCocktailList(target: .category(name: "Ordinary Drink")) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let drinks):
                    self.drinks = drinks
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func goToTheFilterView() {
        //go to the filter view
        router?.showFilter()
    }
}
