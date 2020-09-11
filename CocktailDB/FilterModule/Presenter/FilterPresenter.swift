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
    func getCategoriesList() -> [String]
    func saveToUserDefault(categories: [String])
    var categories: [Category]? { get set }
}

class FilterPresenter: FilterViewPresenterProtocol {
    // MARK: - variables
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
    
    // MARK: - fetch filters
    func fetchFilters() {
        typealias Handler = Result<FiltersCategoryList, Error>
        networkService.loadData(target: .categories) { [weak self] (result: Handler) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.categories = response.categories
                    self.setSelectedFilters()
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    // MARK: - set checked
    func setSelectedFilters() {
        let userFiltersList = UserDefaults.standard.object(forKey: "savedFilters") as? [String]
        if userFiltersList != nil {
            guard let userFiltersList = userFiltersList else { return }
            userFiltersList.forEach { selectedCategories.append($0) }
        } else {
            guard let categories = categories else { return }
            categories.forEach { selectedCategories.append($0.category) }
        }
    }
    
    // MARK: - add ckeck item
    func appendToSelectedCategories(category: String) {
        selectedCategories.append(category)
    }
    
    // MARK: - remove check item
    func removeFromSelectedCategories(category: String) {
        selectedCategories = selectedCategories.filter { $0 != category }
    }
    
    // MARK: - get checed list
    func getCategoriesList() -> [String] {
        return selectedCategories
    }
    
    // MARK: - save to user default storage
    func saveToUserDefault(categories: [String]) {
        UserDefaults.standard.removeObject(forKey: "savedFilters")
        UserDefaults.standard.set(categories, forKey: "savedFilters")
    }
    
    // MARK: - go to Drinks view
    func goToPopView() {
        router?.popToRoot()
    }
}
