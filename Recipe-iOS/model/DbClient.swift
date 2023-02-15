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
    
    func deleteIngredient() {
        
    }
    
    func updateIngredient() {
        
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
