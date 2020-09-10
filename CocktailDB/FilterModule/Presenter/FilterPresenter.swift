//
//  FilterPresenter.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol FilterViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol FilterViewPresenterProtocol: class {
    init(view: FilterViewProtocol, networkService: NetwokrServiceProtocol, router: RouterProtocol)
    func fetchFilters()
    func goToPopView()
    func appendToSelectedCategories(category: String)
    func removeFromSelectedCategories(category: String)
    func getSelectedCategories() -> [String]
    var categories: [Category]? { get set }
}

class FilterPresenter: FilterViewPresenterProtocol {
    private var selectedCategories = [String]()
    weak var view: FilterViewProtocol?
    var router: RouterProtocol?
    let networkService: NetwokrServiceProtocol!
    var categories: [Category]?
    
    required init(view: FilterViewProtocol, networkService: NetwokrServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        fetchFilters()
    }
    
    func fetchFilters() {
        typealias Handler = Result<FiltersCategoryList, Error>
        networkService.loadData(target: .categories) { [weak self] (result: Handler) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.categories = response.categories
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func appendToSelectedCategories(category: String) {
        selectedCategories.append(category)
    }
    
    func removeFromSelectedCategories(category: String) {
        selectedCategories = selectedCategories.filter { $0 != category }
    }
    
    func getSelectedCategories() -> [String] {
        selectedCategories
    }
    
    func goToPopView() {
        router?.popToRoot()
    }
}
