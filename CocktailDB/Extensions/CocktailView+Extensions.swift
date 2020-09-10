//
//  CocktailView+Extensions.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

// MARK: - CocktailView: UITableViewDataSource
extension CocktailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getDrinksAndCategories().count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitle = presenter.getDrinksAndCategories()[section]
        let section = CocktailSection(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        section.setTittle(title: sectionTitle.categoryName)
        return section
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getDrinksAndCategories()[section].drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drink = presenter.getDrinksAndCategories()[indexPath.section].drinks[indexPath.row]
        let cell = cocktailTableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! CoctailCell
        cell.setupCell(cocktail: drink)
        return cell
    }
}

// MARK: - CocktailView: UITableViewDataSource
extension CocktailView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (cocktailTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let index = self.presenter.getDrinksAndCategories().count
                self.presenter.fetchDrinksAndCategory(index: index)
            }
        }
    }
}

// MARK: - CocktailView: CocktailViewProtocol
extension CocktailView: CocktailViewProtocol {
    func succes() {
        cocktailTableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - CocktailView: CocktailNavigationBarDelegate
extension CocktailView: CocktailNavigationBarDelegate {
    func tapFilterAction() {
        presenter.goToTheFilterView()
    }
}
