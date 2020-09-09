//
//  CoctailCell.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 09.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import SDWebImage

class CoctailCell: UITableViewCell {
    @IBOutlet private weak var cocktailImage: UIImageView!
    @IBOutlet private weak var cocktailName: UILabel!
    
    func setupCell(cocktail: Drink?) {
        cocktailImage.sd_setImage(with: cocktail?.imageURL, placeholderImage: UIImage(named: "clear"))
        cocktailName.text = cocktail?.name
        cocktailName.font = UIFont(name: "Roboto-Regular", size: 16)
    }
}
