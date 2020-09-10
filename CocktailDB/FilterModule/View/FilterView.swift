//
//  FilterView.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class FilterView: UIViewController {
    @IBOutlet private weak var filterTableView: UITableView!
    @IBOutlet private weak var filterNavigationBar: FilterNavigationBar!
    var presenter: FilterViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterNavigationBar.filterDelegate = self
    }
}

extension FilterView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = presenter.categories?[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = category?.category
        cell.textLabel?.textColor = #colorLiteral(red: 0.4705343246, green: 0.4706193209, blue: 0.4705289602, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        cell.tintColor = .black
        cell.accessoryType = .checkmark
        return cell
    }
}

extension FilterView: FilterViewProtocol {
    func succes() {
        filterTableView.reloadData()
        let filterFooter = FilterFooter(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 70))
        filterTableView.tableFooterView = filterFooter
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension FilterView: FilterNavigationBarDelegate {
    func tapBackAction() {
        //action
    }
}
