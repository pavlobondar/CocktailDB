//
//  FilterNavigationBar.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

@IBDesignable class FilterNavigationBar: UINavigationBar {
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: FilterNavigationBar.self)
        bundle.loadNibNamed("FilterNavigationBar", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 24)
        setViewShadow()
    }
    
    private func setViewShadow() {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 3
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
    }
}
