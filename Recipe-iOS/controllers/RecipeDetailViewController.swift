//
//  RecipeDetailViewController.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 19/02/2023.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    var onDoneBlock : (() -> Void)?
    var ingredientArr: [Ingredient] = []
    var selectedIngredientArr: [Ingredient] = []
    var displayedIngredientArr: [Ingredient] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    @IBOutlet weak var directionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchIngredients()
        
        if recipe == nil {
            self.title = "Create Recipe"
        } else {
            self.title = "Edit Recipe"
            if let recipeIngredients = recipe?.ingredients {
                for i in recipeIngredients {
                    selectedIngredientArr.append(i as! Ingredient)
                }
            }
            nameField.text = recipe?.name
            directionField.text = recipe?.directions
        }

        reloadIngredients()
        
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        recipeCollectionView.allowsMultipleSelection = true
        
        directionField.layer.borderColor = UIColor.systemGray6.cgColor
        directionField.layer.borderWidth = 1
        directionField.layer.cornerRadius = 8
    }
    

    @IBAction func savePress(_ sender: UIBarButtonItem) {
        let name = nameField.text
        if name == "" {
            nameErrorLabel.text = "Please enter a name for this recipe"
            nameErrorLabel.isHidden = false
            return
        }
        let direction = directionField.text
        let selectedIngredients = selectedIngredientArr
        
        let dbClient = DbClient.getInstance(with: context)
        var result = false
        if recipe == nil {
            result = dbClient.createRecipe(name: name!, directions: direction!, ingredients: selectedIngredients)
        } else {
            result = dbClient.updateRecipe(recipe!, name: name!, directions: direction!, ingredients: selectedIngredients)
        }
        if result {
            onDoneBlock!()
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Something went wrong", message: "Was unable to save recipe", preferredStyle: .alert)
            let action = UIAlertAction(title: "Try Again", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func fetchIngredients() {
        let dbClient = DbClient.getInstance(with: context)
        ingredientArr = dbClient.listIngredient()
    }
    
    
    func reloadIngredients() {
        let nonSelected = ingredientArr.filter { ingredient in
            return !selectedIngredientArr.contains(ingredient)
        }
        displayedIngredientArr = selectedIngredientArr + nonSelected
        recipeCollectionView.reloadData()
    }


    
}

extension RecipeDetailViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.displayedIngredientArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.RECIPE_INGREDIENT_CELL_NAME, for: indexPath) as! IngredientCollectionViewCell
        let ingredient = self.displayedIngredientArr[indexPath.row]
        cell.setUp(label: ingredient.name!, isSelected: selectedIngredientArr.contains(ingredient))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? IngredientCollectionViewCell {
            cell.select()
        }
        let selectedIngredient = displayedIngredientArr[indexPath.row]
        if !selectedIngredientArr.contains(selectedIngredient){
            selectedIngredientArr.append(selectedIngredient)
        } else {
            selectedIngredientArr = selectedIngredientArr.filter { ingredient in
                ingredient.id != selectedIngredient.id
            }
        }
        reloadIngredients()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? IngredientCollectionViewCell {
            cell.deselect()
        }
        let deselectedIngredient = displayedIngredientArr[indexPath.row]
        selectedIngredientArr = selectedIngredientArr.filter { ingredient in
            ingredient.id != deselectedIngredient.id
        }
        reloadIngredients()
    }
    
}
