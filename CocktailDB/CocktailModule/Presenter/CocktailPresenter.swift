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
    func goToTheFilterView()
    func fetchDrinksAndCategory(index: Int)
    func fetchNextDrinksAndCategory()
    func getDrinksAndCategories() -> [DrinksAndCategory]
    var drinks: [Drink]? { get set }
}

class CocktailPresenter: CocktailViewPresenterProtocol {
    weak var view: CocktailViewProtocol?
    var router: RouterProtocol?
    let networkService: NetwokrServiceProtocol!
    var drinks: [Drink]?
    var drinksAndCategory = [DrinksAndCategory]()
    var nextCategoryIndex = 0
    
    var drinksCategory = ["Ordinary Drink", "Cocktail", "Cocoa", "Shot"]
    
    required init(view: CocktailViewProtocol, networkService: NetwokrServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        fetchDrinksAndCategory(index: 0)
    }
    
    func fetchDrinksAndCategory(index: Int) {
        if drinksCategory.indices.contains(index) {
            typealias Handler = Result<DrinksList, Error>
            networkService.loadData(target: .cocktail(name: drinksCategory[index])) { [weak self] (result: Handler) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        let item = DrinksAndCategory(categoryName: self.drinksCategory[index], drinks: response.drinks)
                        self.drinksAndCategory.append(item)
                        self.view?.succes()
                        self.nextCategoryIndex += 1
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchNextDrinksAndCategory() {
        fetchDrinksAndCategory(index: nextCategoryIndex)
    }
    
    func getDrinksAndCategories() -> [DrinksAndCategory] {
        return drinksAndCategory
    }
    
    func goToTheFilterView() {
        router?.showFilter()
    }
}
