//
//  CocktailView.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class CocktailView: UIViewController {
    @IBOutlet private weak var cocktailNavigationBar: CocktailNavigationBar!
    @IBOutlet internal weak var cocktailTableView: UITableView!
    var presenter: CocktailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - register CoctailCell
        let cocktailCell = UINib(nibName: "CoctailCell", bundle: nil)
        cocktailTableView.register(cocktailCell, forCellReuseIdentifier: "cocktailCell")
        // MARK: - сocktailDelegate
        cocktailNavigationBar.сocktailDelegate = self
        // MARK: - NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable),
                                               name: NSNotification.Name("tapApplyAction"), object: nil)
    }
    
    @objc private func updateTable() {
        presenter.updateTable()
    }
}
