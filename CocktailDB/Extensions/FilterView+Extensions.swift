//
//  FilterView+Extensions.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

// MARK: - FilterView: UITableViewDataSource
extension FilterView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = presenter.categories?[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = category?.category
        cell.textLabel?.textColor = #colorLiteral(red: 0.4705343246, green: 0.4706193209, blue: 0.4705289602, alpha: 1)
        if let category = category?.category {
            cell.accessoryType = presenter.getSelectedCategories().contains(category) ? .checkmark : .none
        }
        cell.textLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        cell.tintColor = .black
        return cell
    }
}

// MARK: - FilterView: UITableViewDelegate
extension FilterView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = presenter.categories?[indexPath.row].category
        if let category = category {
            if presenter.getSelectedCategories().contains(category) {
                filterTableView.cellForRow(at: indexPath)?.accessoryType = .none
                presenter.removeFromSelectedCategories(category: category)
            } else {
                filterTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                presenter.appendToSelectedCategories(category: category)
            }
        }
    }
}

// MARK: - FilterView: FilterViewProtocol
extension FilterView: FilterViewProtocol {
    func succes() {
        filterTableView.reloadData()
        let filterFooter = FilterFooter(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 70))
        filterFooter.filterFooterDelegate = self
        filterTableView.tableFooterView = filterFooter
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - FilterView: FilterFooterDelegate
extension FilterView: FilterFooterDelegate {
    func tapApplyAction() {
        presenter.goToPopView()
        print(presenter.getSelectedCategories())
    }
}

// MARK: - FilterView: FilterNavigationBarDelegate
extension FilterView: FilterNavigationBarDelegate {
    func tapBackAction() {
        presenter.goToPopView()
    }
}
