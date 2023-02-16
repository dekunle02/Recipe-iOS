//
//  IngredientDetailViewController.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 15/02/2023.
//

import UIKit

class IngredientDetailViewController: UIViewController {

    var ingredient: Ingredient?
    var onDoneBlock : (() -> Void)?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var inStockSwitch: UISwitch!
    @IBOutlet weak var pageTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ingredient != nil {
            pageTitleLabel.text = "Edit Ingredient"
            nameField.text = ingredient?.name
            inStockSwitch.isOn = ingredient?.inStock == true
        } else {
            pageTitleLabel.text = "Add Ingredient"
        }
    }
    
    
    @IBAction func savePress(_ sender: UIButton) {
        let dbClient = DbClient.getInstance(with: context)
        let enteredName = nameField.text!
        let enteredStock = inStockSwitch.isOn
        var result = false
        
        if let validIngredient = ingredient {
            result = dbClient.updateIngredient(validIngredient, name: enteredName, inStock: enteredStock)
        } else {
            result = dbClient.createIngredient(name: enteredName, inStock: enteredStock)
        }

        if result == true {
            onDoneBlock!()
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Something went wrong", message: "Was unable to save ingredient", preferredStyle: .alert)
            let action = UIAlertAction(title: "Try Again", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
  

}
