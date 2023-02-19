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
    var inStockIngredientArr: [Ingredient] = []
    var outOfStockIngredientArr: [Ingredient] = []
    let sections = ["In Stock", "Out of Stock"]

    var selectedIngredient: Ingredient? = nil
    var isAddingNewIngredient: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = K.INGREDRIENT_FRAGMENT_NAME
        tableView.register(UINib(nibName: K.INGREDIENT_CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: K.INGREDIENT_CELL_NAME)
        reloadPage()
    }
    

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        isAddingNewIngredient = true
        performSegue(withIdentifier: K.INGREDIENT_LIST_TO_DETAIL_SEGUE, sender: self)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inStockArr = ingredientArr.filter { ingredient in
          return ingredient.inStock == true
        }
        return section == 0 ? inStockArr.count : ingredientArr.count - inStockArr.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
//      custom section labels
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
//            let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 20))
//            label.font = UIFont.systemFont(ofSize: 15)
//            label.text = ingredientArr[section].inStock ? "In Stock" : "Out of Stock"
//        label.textColor = UIColor.lightGray
//
//           view.addSubview(label)
//           return view
//         }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.INGREDIENT_CELL_NAME, for: indexPath) as! IngredientTableViewCell
        if indexPath.section == 0 {
            let ingredient = inStockIngredientArr[indexPath.row]
            cell.nameLabel?.text = ingredient.name
            cell.stockLabel?.text = " In Stock "
            cell.stockLabel?.backgroundColor = UIColor(named: "ColorGreen")
            cell.stockLabel?.textColor = UIColor(named: "ColorOnGreen")
        } else {
            let ingredient = outOfStockIngredientArr[indexPath.row]
            cell.nameLabel?.text = ingredient.name
            cell.stockLabel?.text = " Out of Stock "
            cell.stockLabel?.backgroundColor = UIColor(named: "ColorError")
            cell.stockLabel?.textColor = UIColor(named: "ColorOnError")
        }
        return cell
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient = ingredientArr[indexPath.row]
        isAddingNewIngredient = false
        selectedIngredient = ingredient
        performSegue(withIdentifier: K.INGREDIENT_LIST_TO_DETAIL_SEGUE, sender: self)
    }

    func reloadPage() {
        let dbClient = DbClient.getInstance(with: context)
        ingredientArr = dbClient.listIngredient()
        inStockIngredientArr = ingredientArr.filter { ingredient in
            return ingredient.inStock == true
          }
        outOfStockIngredientArr = ingredientArr.filter { ingredient in
            return ingredient.inStock == false
        }
        tableView.reloadData()
    }

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.INGREDIENT_LIST_TO_DETAIL_SEGUE {
            let destinationVC = segue.destination as! IngredientDetailViewController
            destinationVC.ingredient = isAddingNewIngredient ? nil : selectedIngredient
            destinationVC.onDoneBlock = self.reloadPage
        }
    }
    

}
