//
//  RecipeDetailViewController.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 19/02/2023.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Create Recipe"
    }
    

    @IBAction func savePress(_ sender: UIBarButtonItem) {
        print("Save Pressed!")
        navigationController?.popViewController(animated: true)
    }

    
}
