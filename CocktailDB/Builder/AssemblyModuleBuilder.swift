//
//  ModuleBuilder.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createCocktailModule(router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createCocktailModule(router: RouterProtocol) -> UIViewController {
        let cocktailView = CocktailView()
        let networkService = NetwokrService()
        let cocktailPresenter = CocktailPresenter(view: cocktailView, networkService: networkService, router: router)
        cocktailView.presenter = cocktailPresenter
        return cocktailView
    }
}