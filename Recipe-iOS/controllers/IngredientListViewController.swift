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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("*******")
        self.title = K.INGREDRIENT_FRAGMENT_NAME
        reloadPage()
    }
    

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.INGREDIENT_LIST_TO_DETAIL_SEGUE, sender: self)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.INGREDIENT_CELL_NAME, for: indexPath)
        let ingredient = ingredientArr[indexPath.row]
        cell.textLabel?.text = ingredient.name
        return cell
        }


    func reloadPage() {
        print("page reloaded!")
        let dbClient = DbClient.getInstance(with: context)
        ingredientArr = dbClient.listIngredient()
        tableView.reloadData()
    }

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.INGREDIENT_LIST_TO_DETAIL_SEGUE {
            let destinationVC = segue.destination as! IngredientDetailViewController
            destinationVC.ingredient = nil
            destinationVC.onDoneBlock = self.reloadPage
        }
    }
    

}
