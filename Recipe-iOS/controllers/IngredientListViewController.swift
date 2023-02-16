//
//  IngredientListViewController.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 13/02/2023.
//

import UIKit

class IngredientListViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var ingredientArr: [Ingredient] = []
    var selectedIngredient: Ingredient? = nil
    var isAddingNewIngredient: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = K.INGREDRIENT_FRAGMENT_NAME
        
        tableView.register(UINib(nibName: K.INGREDIENT_CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: K.INGREDIENT_CELL_NAME)
        reloadPage()
    }
    

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        isAddingNewIngredient = true
        performSegue(withIdentifier: K.INGREDIENT_LIST_TO_DETAIL_SEGUE, sender: self)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.INGREDIENT_CELL_NAME, for: indexPath) as! IngredientTableViewCell
        let ingredient = ingredientArr[indexPath.row]
        cell.nameLabel?.text = ingredient.name
        cell.stockLabel?.text = ingredient.inStock ? " In Stock " : " Out of Stock "
        cell.stockLabel?.backgroundColor = ingredient.inStock ?  UIColor(named: "ColorGreen") : UIColor(named: "ColorError")
        cell.stockLabel?.textColor = ingredient.inStock ? UIColor(named: "ColorOnGreen") : UIColor(named: "ColorOnError")
        return cell
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient = ingredientArr[indexPath.row]
        isAddingNewIngredient = false
        selectedIngredient = ingredient
        performSegue(withIdentifier: K.INGREDIENT_LIST_TO_DETAIL_SEGUE, sender: self)
    }

    func reloadPage() {
        let dbClient = DbClient.getInstance(with: context)
        ingredientArr = dbClient.listIngredient()
        tableView.reloadData()
    }

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.INGREDIENT_LIST_TO_DETAIL_SEGUE {
            let destinationVC = segue.destination as! IngredientDetailViewController
            destinationVC.ingredient = isAddingNewIngredient ? nil : selectedIngredient
            destinationVC.onDoneBlock = self.reloadPage
        }
    }
    

}
