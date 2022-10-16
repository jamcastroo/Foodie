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
    
    var recipe: Recipie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeNameLabel.text = recipe.name
        recipeCategory.text = recipe.category
        recipeCuisineLabel.text = recipe.cusine
        recipeDescriptionTextView.text = recipe.instructions
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
