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
    
    let categories = ["AMERICAN","BRITISH","CHINESE","FRENCH","GREEK","INDIAN","ITALIAN","JAMAICAN","JAPANESE","MEXICAN","MOROCCAN","PORTUGUESE","SPANISH","TURKISH"]
    
    var selectedCategory = "AMERICAN"
    var recipies: [Recipie] = []
    let service = FreeMealDBService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFood()
        
    }
    
    func getFood() {
        Task {
            recipies = await service.getAll(route: .recipe(country: selectedCategory))
            recipiesCollection.reloadData()
        }
    }
    
//     MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailFromHome" {
            let destination = segue.destination as! RecipeDetailViewController
            let id = sender as! String
            destination.id = id
        }
    }
}

extension FoodieHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollection {
            return categories.count
        } else {
            return recipies.count
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
            collectionCell.recipeTitle.text = recipies[indexPath.row].name
            collectionCell.imagePath = recipies[indexPath.row].thumbnail
            return collectionCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollection {
            selectedCategory = categories[indexPath.row]
            recipiesCollection.reloadData()
            recipiesCollection.contentOffset.x = 0
            getFood()
        } else {
            performSegue(withIdentifier: "detailFromHome", sender: recipies[indexPath.row].id)
        }
    }
    
    //Permite o tamanho dinâmico para a segunda collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recipiesCollection {
            return CGSize(width: collectionView.frame.width - 100 , height: collectionView.frame.height - (collectionView.safeAreaInsets.top + collectionView.safeAreaInsets.bottom))
        } else {
            return CGSize(width: 150, height: 100)
        }
    }
}
