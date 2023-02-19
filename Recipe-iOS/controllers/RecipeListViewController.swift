//
//  RecipeListViewController.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 13/02/2023.
//

import UIKit

class RecipeListViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recipeArr : [Recipe] = []
    
    var selectedRecipe: Recipe? = nil
    var isAddingNewRecipe: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = K.RECIPE_FRAGMENT_NAME
        reloadPage()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.RECIPE_CELL_NAME, for: indexPath)
        let recipe = recipeArr[indexPath.row]
        cell.textLabel?.text = recipe.name
        return cell
    }


    @IBAction func addPress(_ sender: UIBarButtonItem) {
        isAddingNewRecipe = true
        performSegue(withIdentifier: K.RECIPE_LIST_TO_DETAIL_SEGUE, sender: self)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.RECIPE_LIST_TO_DETAIL_SEGUE {
            let destinationVC = segue.destination as! RecipeDetailViewController
            destinationVC.recipe = isAddingNewRecipe ? nil : selectedRecipe
        }
    }

    
    func reloadPage() {
        let dbClient = DbClient.getInstance(with: context)
        recipeArr = dbClient.listRecipes()
        tableView.reloadData()
    }

}
