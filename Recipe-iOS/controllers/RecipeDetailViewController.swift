//
//  RecipeDetailViewController.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 19/02/2023.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    var ingredientArr = ["Banana", "Tomato", "Spinach"]
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    @IBOutlet weak var directionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        self.title = "Create Recipe"
        directionField.layer.borderColor = UIColor.systemGray6.cgColor
        directionField.layer.borderWidth = 2
        directionField.layer.cornerRadius = 8
    }
    

    @IBAction func savePress(_ sender: UIBarButtonItem) {
        print("Save Pressed!")
        navigationController?.popViewController(animated: true)
    }

    
}

extension RecipeDetailViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.ingredientArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.RECIPE_INGREDIENT_CELL_NAME, for: indexPath) as! IngredientCollectionViewCell
        cell.textLabel.text = self.ingredientArr[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//    }
    
    
    
    
}
