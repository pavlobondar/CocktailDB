//
//  FilterView.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class FilterView: UIViewController {
    @IBOutlet private weak var filterNavigationBar: FilterNavigationBar!
    @IBOutlet internal weak var filterTableView: UITableView!
    var presenter: FilterViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - filterDelegate
        filterNavigationBar.filterDelegate = self
    }
}
