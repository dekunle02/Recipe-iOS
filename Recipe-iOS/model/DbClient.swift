//
//  db.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 13/02/2023.
//
import UIKit
import Foundation
import CoreData

 class DbClient {
    var context: NSManagedObjectContext? = nil
    static var instance: DbClient? = nil
    
     private init (context: NSManagedObjectContext) {
         self.context = context
     }
    
    static func getInstance(with context: NSManagedObjectContext) -> DbClient {
        if let currentInstance = instance  {
            return currentInstance
        } else {
            let newInstance = DbClient(context: context)
            self.instance = newInstance
            return newInstance
        }
    }
    
    
    //MARK: - CRUD Ingredient
    
     func createIngredient(name: String, inStock:Bool = false) -> Bool {
         guard let context = context else {
             return false
         }
         let ingredient = Ingredient(context: context)
         ingredient.name = name
         ingredient.inStock = inStock
         return self.saveContext()
    }
    
    func listIngredient() -> [Ingredient] {
        guard let context = self.context else {
            return []
        }
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        do {
            let ingredientArr = try context.fetch(request)
            return ingredientArr
        } catch {
            print("Error fetching context \(error)")
            return []
        }
    }
     
     func updateIngredient(_ ingredient: Ingredient, name:String, inStock:Bool) -> Bool {
         ingredient.setValue(name, forKey: "name")
         ingredient.setValue(inStock, forKey: "inStock")
         return self.saveContext()
     }
    
     func deleteIngredient(_ ingredient: Ingredient) -> Bool {
         self.context?.delete(ingredient)
         return saveContext()
    }
    
     //MARK: - CRUD Recipes
     func createRecipe(name: String, directions: String,  ingredients: [Ingredient]) -> Bool {
         guard let context = context else {
             return false
         }
         let recipe = Recipe(context: context)
         recipe.name = name
         recipe.directions = directions
         recipe.ingredients = NSSet(array: ingredients)
         return self.saveContext()
    }
    
    func listRecipes() -> [Recipe] {
        guard let context = self.context else {
            return []
        }
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            let recipeArr = try context.fetch(request)
            return recipeArr
        } catch {
            print("Error fetching context \(error)")
            return []
        }
    }
     
     func updateRecipe(_ recipe: Recipe, name:String, directions: String, ingredients:[Ingredient]) -> Bool {
         recipe.setValue(name, forKey: "name")
         recipe.setValue(directions, forKey: "directions")
         recipe.ingredients = NSSet(array: ingredients)
         return self.saveContext()
     }
    
     func deleteRecipe(_ recipe: Recipe) -> Bool {
         self.context?.delete(recipe)
         return saveContext()
    }
    
     
     func saveContext() -> Bool {
         do {
             try self.context?.save()
             return true
         } catch {
             print("Error saving context \(error)")
             return false
         }
     }
    
    
    
    
    
}
