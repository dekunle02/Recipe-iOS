//
//  IngredientTableViewCell.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 16/02/2023.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stockLabel.layer.cornerRadius = 5
        stockLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
