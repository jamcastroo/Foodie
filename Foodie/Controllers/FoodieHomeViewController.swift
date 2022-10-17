//
//  FoodieHomeViewController.swift
//  Foodie
//
//  Created by Jamile Castro on 16/10/22.
//

import UIKit

class FoodieHomeViewController: UIViewController {
    
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var recipiesCollection: UICollectionView!
    
    let categories = ["AMERICAN","BRAZILLIAN","BRITISH","CANADIAN","CHINESE","CROATIAN","DUTCH","EGYPTIAN","FRENCH","GREEK","INDIAN","ITALIAN","IRISH","JAMAICAN","JAPANESE","KENYAN","MALAYSIAN","MEXICAN","MOROCCAN","PORTUGUESE","SPANISH","TURKISH"]
    
    var selectedCategory = "AMERICAN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension FoodieHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollection {
            return categories.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollection {
            let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionCell", for: indexPath) as! CategoryCollectionViewCell
            collectionCell.categoryTitle.text = categories[indexPath.row]
            collectionCell.categoryImage.image = UIImage(named: categories[indexPath.row]) ?? UIImage(named: "AMERICAN")
            return collectionCell
        } else {
            let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCollectionCell", for: indexPath) as! RecipeCollectionViewCell
            collectionCell.recipeTitle.text = selectedCategory
            collectionCell.recipeImage.image = UIImage(named: selectedCategory)
            return collectionCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollection {
            selectedCategory = categories[indexPath.row]
            recipiesCollection.reloadData()
        }
    }
}
