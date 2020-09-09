//
//  CocktailNavigationBar.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

@objc protocol CocktailNavigationBarDelegate: class {
    @objc optional func tapFilterAction()
}

@IBDesignable class CocktailNavigationBar: UINavigationBar {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var goToFilterButton: UIButton!
    @IBOutlet private var view: UIView!
    weak var сocktailDelegate: CocktailNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: CocktailNavigationBar.self)
        bundle.loadNibNamed("CocktailNavigationBar", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 24)
        setViewShadow()
    }
    
    @IBAction private func tapFilterButton(_ sender: UIButton) {
        сocktailDelegate?.tapFilterAction?()
    }
    
    private func setViewShadow() {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 3
    }
}
