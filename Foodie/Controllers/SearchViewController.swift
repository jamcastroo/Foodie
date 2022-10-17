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
    
    var data:[String] = ["AMERICAN","BRAZILLIAN","BRITISH","CHINESE","FRENCH","GREEK","INDIAN","ITALIAN","JAMAICAN","JAPANESE","MEXICAN","MOROCCAN","PORTUGUESE","SPANISH","TURKISH"]
    var filterUse:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterUse = self.data
        self.configDelegate()

    }
    
    func configDelegate(){
        self.search.delegate = self
        self.search.dataSource = self
        self.searching.delegate = self
    }
    
}

extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.filterUse[indexPath.row]
        return cell
    }
    
}

extension SearchViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterUse = []
        
        if searchText.isEmpty{
            self.filterUse = self.data
        }else{
            for value in data{
                if value.uppercased().contains(searchText.uppercased()){
                    self.filterUse.append(value)
                }
            }
        }
        self.search.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
