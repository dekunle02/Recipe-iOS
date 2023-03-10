//
//  K.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 13/02/2023.
//

import Foundation

struct K {
    
    static let APP_NAME = "Recipea"
    
    static let INGREDRIENT_FRAGMENT_NAME = "Ingredients"
    static let INGREDIENT_LIST_TO_DETAIL_SEGUE = "ingredientListToDetail"
    static let INGREDIENT_CELL_NAME = "ingredientCell"
    static let INGREDIENT_CELL_NIB_NAME = "IngredientTableViewCell"

    static let RECIPE_FRAGMENT_NAME = "Recipes"
    static let RECIPE_LIST_TO_DETAIL_SEGUE = "recipeListToDetail"
    static let RECIPE_CELL_NAME = "recipeCell"
    static let RECIPE_INGREDIENT_CELL_NAME = "ingredientCollectionCell"
    
    static let SUGGESTED_RECIPE_CELL_NAME = "suggestedCell"
    static let SUGGESTED_CELL_NIB_NAME = "SuggestedTableViewCell"
    
    
    static func getBannerAdId(testMode: Bool = true) -> String{
        return testMode ? "ca-app-pub-3940256099942544/2934735716" : "ca-app-pub-2680408732019277/3169920759"
    }
    
}
