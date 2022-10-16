//
//  FoodCatalogue.swift
//  Foodie
//
//  Created by Jamile Castro on 13/10/22.
//

import UIKit

class FoodCatalogue: UIViewController, UITableViewDataSource {
    
    

    @IBOutlet weak var category: UITableView!
    
    let categories = ["AMERICAN","BRAZILLIAN","BRITISH","CANADIAN","CHINESE","CROATIAN","DUTCH","EGYPTIAN","FRENCH","GREEK","INDIAN","ITALIAN","IRISH","JAMAICAN","JAPANESE","KENYAN","MALAYSIAN","MEXICAN","MOROCCAN","PORTUGUESE","SPANISH","TURKISH"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }

}

