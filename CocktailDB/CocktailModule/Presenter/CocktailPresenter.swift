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
    func updateTable()
    func fetchNextDrinksAndCategory()
    func getDrinksAndCategories() -> [DrinksAndCategory]
    var drinks: [Drink]? { get set }
}

class CocktailPresenter: CocktailViewPresenterProtocol {
    // MARK: - variables
    weak var view: CocktailViewProtocol?
    var router: RouterProtocol?
    let networkService: NetwokrServiceProtocol!
    var drinks: [Drink]?
    var drinksAndCategory = [DrinksAndCategory]()
    var nextCategoryIndex = 0
    
    required init(view: CocktailViewProtocol, networkService: NetwokrServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.updateTable()
    }
    
    // MARK: - fetch drinks and categories
    func fetchDrinksAndCategory(index: Int) {
        let savedFilters = UserDefaults.standard.object(forKey: "savedFilters") as? [String]
        if let savedFilters = savedFilters, savedFilters.indices.contains(index) {
            typealias Handler = Result<DrinksList, Error>
            networkService.loadData(target: .cocktail(name: savedFilters[index])) { [weak self] (result: Handler) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        let item = DrinksAndCategory(categoryName: savedFilters[index], drinks: response.drinks)
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
    
    // MARK: - update table view after load new data
    func updateTable() {
        drinksAndCategory = []
        nextCategoryIndex = 0
        fetchDrinksAndCategory(index: 0)
    }
    
    // MARK: - counter
    func fetchNextDrinksAndCategory() {
        fetchDrinksAndCategory(index: nextCategoryIndex)
    }
    
    // MARK: - get drinks with categories
    func getDrinksAndCategories() -> [DrinksAndCategory] {
        return drinksAndCategory
    }
    
    // MARK: - go to Filter view
    func goToTheFilterView() {
        router?.showFilter()
    }
}
