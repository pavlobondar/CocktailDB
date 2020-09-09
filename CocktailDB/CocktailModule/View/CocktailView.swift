//
//  CocktailView.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class CocktailView: UIViewController {
    @IBOutlet private weak var cocktailTableView: UITableView!
    var presenter: CocktailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cocktailCell")
    }
}

extension CocktailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.drinks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drink = presenter.drinks?[indexPath.row]
        let cell = cocktailTableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath)
        cell.textLabel?.text = drink?.name
        return cell
    }
}

extension CocktailView: CocktailViewProtocol {
    func succes() {
        cocktailTableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
