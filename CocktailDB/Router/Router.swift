//
//  Router.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showFilter()
    func popToRoot()
}

class Router: RouterProtocol {
    // MARK: - variables
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    // MARK: - init first view controller
    func initialViewController() {
        if let navigationController = navigationController {
            guard let cocktailView = assemblyBuilder?.createCocktailModule(router: self) else { return }
            navigationController.viewControllers = [cocktailView]
        }
    }
    
    // MARK: - go to filter view controller
    func showFilter() {
        if let navigationController = navigationController {
            guard let filterView = assemblyBuilder?.createFilterModule(router: self) else { return }
            navigationController.pushViewController(filterView, animated: true)
        }
    }
    
    // MARK: - go to drinks view controller
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
