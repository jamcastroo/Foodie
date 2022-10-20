//
//  SearchViewController.swift
//  Foodie
//
//  Created by Jamile Castro on 13/10/22.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var search: UITableView!
    @IBOutlet weak var searching: UISearchBar!
    
    var meals:[Recipie] = [] {
        didSet {
            search.reloadData()
        }
    }
    let service = FreeMealDBService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDelegate()
        title = "Search Meal"
    }
    
    func configDelegate(){
        self.search.delegate = self
        self.search.dataSource = self
        self.searching.delegate = self
    }
    
    //     MARK: - Navigation

    //    Navegação feita pela storyboard usando segues para mostrar o detalhe
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DetailFromSearch" {
                let destination = segue.destination as! RecipeDetailViewController
                let id = sender as! String
                destination.id = id
            }
        }
    
}

extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.meals[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailFromSearch", sender: meals[indexPath.row].id)
    }
}

extension SearchViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty{
            meals = []
        }else{
            Task {
                meals = await service.getAll(route: .search(meal: searchText))
            }
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
