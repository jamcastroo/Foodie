//
//  RecipeDetail.swift
//  Foodie
//
//  Created by Jamile Castro on 13/10/22.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeCategory: UILabel!
    @IBOutlet weak var recipeCuisineLabel: UILabel!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    
    var id: String!
    let service = FreeMealDBService()
    var recipe: Recipie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInformation()
    }
    
    func configureDetails() {
        recipeNameLabel.text = recipe?.name
        recipeCategory.text = recipe?.category
        recipeCuisineLabel.text = recipe?.cusine
        recipeDescriptionTextView.text = recipe?.instructions
    }
    
    func getInformation() {
        Task {
            recipe = await service.getAll(route: .details(id: id)).first
            if let imagePath = recipe?.thumbnail {
                let image = await service.getImageFrom(path: imagePath)
                DispatchQueue.main.async {
                    self.recipeImage.image = image
                }
            }
            
            DispatchQueue.main.async {
                self.configureDetails()
            }
        }
    }
}
