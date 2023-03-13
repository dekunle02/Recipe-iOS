//
//  ViewController.swift
//  Recipe-iOS
//
//  Created by Samad Adeleke on 13/02/2023.
//

import UIKit
import GoogleMobileAds

class HomeViewController: UIViewController {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var recipeStack: UIStackView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var suggestedTable: UITableView!
    @IBOutlet weak var ingredientStack: UIStackView!
    @IBOutlet weak var noRecordsLabel: UILabel!
    @IBOutlet weak var suggestedStack: UIStackView!
    
    var bannerView: GADBannerView!
    
    var recipeArr: [SuggestedRecipe] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
         suggestedTable.dataSource = self
        suggestedTable.register(UINib(nibName: K.SUGGESTED_CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: K.SUGGESTED_RECIPE_CELL_NAME)
        setCards()
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        // change testMode to False in production
        bannerView.adUnitID = K.getBannerAdId(testMode: true)
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadPage()
    }
    
    func setCards() {
        ingredientStack.isLayoutMarginsRelativeArrangement = true
        ingredientStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        ingredientStack.layer.cornerRadius = 10
        
        recipeStack.isLayoutMarginsRelativeArrangement = true
        recipeStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        recipeStack.layer.cornerRadius = 10
        
        suggestedStack.isLayoutMarginsRelativeArrangement = true
        suggestedStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        suggestedStack.layer.cornerRadius = 10
    }
    
    
    func reloadPage() {
        let dbClient = DbClient.getInstance(with: context)
        let plainRecipes = dbClient.listRecipes()
        let plainIngredients = dbClient.listIngredient()
        
        if plainRecipes.count == 0 && plainIngredients.count == 0 {
            noRecordsLabel.isHidden = false
        } else {
            noRecordsLabel.isHidden = true
        }
        
        recipeLabel.text = String(plainRecipes.count)
        ingredientLabel.text = String(plainIngredients.count)
        let unsortedRecipes = SuggestedRecipe.toSuggestedRecipe(plainRecipes)
        recipeArr = SuggestedRecipe.rankByStockAvailability(unsortedRecipes)
        suggestedTable.reloadData()
    }
    
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
           bannerView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(bannerView)
           view.addConstraints(
             [NSLayoutConstraint(item: bannerView,
                                 attribute: .bottom,
                                 relatedBy: .equal,
                                 toItem: view.safeAreaLayoutGuide,
                                 attribute: .bottom,
                                 multiplier: 1,
                                 constant: 0),
              NSLayoutConstraint(item: bannerView,
                                 attribute: .centerX,
                                 relatedBy: .equal,
                                 toItem: view,
                                 attribute: .centerX,
                                 multiplier: 1,
                                 constant: 0)
             ])
          }

}

//MARK: - TableView Extension

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.SUGGESTED_RECIPE_CELL_NAME, for: indexPath) as! SuggestedTableViewCell
        let recipe = recipeArr[indexPath.row]
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.recipeName?.text = recipe.name
        cell.descriptionLabel?.text = recipe.description
        return cell
    }
    
}
