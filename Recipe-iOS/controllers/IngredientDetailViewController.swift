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
        pageTitleLabel.text = ingredient == nil ? "Add Ingredient" : "Ingredient Detail"
    }
    

    @IBAction func savePress(_ sender: UIButton) {
        let dbClient = DbClient.getInstance(with: context)
        let result = dbClient.createIngredient(name: nameField.text!, inStock: inStockSwitch.isOn)

        if result == true {
            onDoneBlock!()
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Something went wrong", message: "Was unable to save new ingredient", preferredStyle: .alert)
            let action = UIAlertAction(title: "Try Again", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        //        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
