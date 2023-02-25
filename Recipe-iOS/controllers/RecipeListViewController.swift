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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipeArr[indexPath.row]
        isAddingNewRecipe = false
        selectedRecipe = recipe
        performSegue(withIdentifier: K.RECIPE_LIST_TO_DETAIL_SEGUE, sender: self)
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.RECIPE_LIST_TO_DETAIL_SEGUE {
            let destinationVC = segue.destination as! RecipeDetailViewController
            destinationVC.recipe = isAddingNewRecipe ? nil : selectedRecipe
            destinationVC.onDoneBlock = self.reloadPage
        }
    }

    
    func reloadPage() {
        let dbClient = DbClient.getInstance(with: context)
        recipeArr = dbClient.listRecipes()
        tableView.reloadData()
    }

}
