//
//  CocktailSection.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class CocktailSection: UIView {
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var sectionTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        let bundle = Bundle.init(for: CocktailSection.self)
        if let viewsToAdd = bundle.loadNibNamed("CocktailSection", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(view)
            contentView.frame = self.bounds
            sectionTitleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
            sectionTitleLabel.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }
    
    func setTittle(title: String) {
        sectionTitleLabel.text = title
    }
}
