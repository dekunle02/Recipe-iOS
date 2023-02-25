//
//  SuggestedRecipe.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 25/02/2023.
//

import Foundation

struct SuggestedRecipe {
    let recipe: Recipe
    let name: String
    let outOfStockArr: [Ingredient]
    let description: String
    
    init(from r: Recipe)  {
        recipe = r
        name = r.name!
        outOfStockArr = SuggestedRecipe.getOutOfStockIngredients(recipe)
        description = SuggestedRecipe.makeDesc(from: outOfStockArr)
    }
    
    private static func getOutOfStockIngredients(_ recipe: Recipe) -> [Ingredient]{
        var arr: [Ingredient] = []
        if let recipeIngredients = recipe.ingredients {
            for i in recipeIngredients {
                if !(i as! Ingredient).inStock {
                    arr.append(i as! Ingredient)
                }
            }
        }
        return arr
    }
    
    private static func makeDesc(from ingredients: [Ingredient]) -> String {
        if ingredients.count == 0 {
            return "All ingredients available"
        }
        let ingredientNames = ingredients.map { $0.name ?? ""}
        return "Ingredients needed: \(ingredientNames.joined(separator: ", "))"
    }
    
 
    static func rankByStockAvailability(_ recipes: [SuggestedRecipe]) -> [SuggestedRecipe] {
        return recipes.sorted { itemA, itemB in
            return itemA.outOfStockArr.count < itemB.outOfStockArr.count
        }
    }
    
    static func toSuggestedRecipe(_ r: [Recipe]) -> [SuggestedRecipe] {
        return r.map{ SuggestedRecipe(from: $0) }
    }
    
    
}
