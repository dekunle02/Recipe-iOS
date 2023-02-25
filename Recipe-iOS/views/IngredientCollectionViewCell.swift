//
//  IngredientCollectionViewCell.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 21/02/2023.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!

    @IBOutlet weak var containingView: UIView!
    @IBOutlet weak var checkmark: UIImageView!
    
    
    func setUp(label: String, isSelected: Bool) {
        textLabel.text = label
        
        if isSelected {
            select()
        } else {
            deselect()
        }
    }
    
    func select() {
        containingView.layer.cornerRadius = 5
        containingView.layer.borderWidth = 0
        containingView.backgroundColor = UIColor(named: "ColorPrimary")
        checkmark.alpha = 1
        checkmark.tintColor = UIColor(named: "ColorBackground")
        textLabel.textColor = UIColor(named: "ColorBackground")
    }
    
    func deselect() {
        containingView.layer.cornerRadius = 5
        containingView.layer.borderWidth = 2
        containingView.layer.borderColor = UIColor.systemGray6.cgColor
        containingView.backgroundColor = UIColor.clear
        checkmark.alpha = 0
        textLabel.textColor = UIColor(named: "ColorOnBackground")
    }
    
}
