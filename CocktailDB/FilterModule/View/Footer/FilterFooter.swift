//
//  FilterFooter.swift
//  CocktailDB
//
//  Created by Pavel Bondar on 10.09.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

@objc protocol FilterFooterDelegate {
    @objc optional func tapApplyAction()
}

class FilterFooter: UIView {
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var applyButton: UIButton!
    var filterFooterDelegate: FilterFooterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let bundle = Bundle.init(for: FilterFooter.self)
        if let viewsToAdd = bundle.loadNibNamed("FilterFooter", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            applyButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        filterFooterDelegate?.tapApplyAction?()
    }
}
