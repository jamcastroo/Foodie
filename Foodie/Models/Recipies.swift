//
//  Recipies.swift
//  Foodie
//
//  Created by Jamile Castro on 13/10/22.
//

import Foundation

struct APIReponse: Codable {
    var meals: [Recipie]
}

struct Recipie: Codable {
    var id: String
    var name: String
    var category: String?
    var cusine: String?
    var instructions: String?
    var thumbnail: String?
    var youtubeLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case cusine = "strArea"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case youtubeLink = "strYoutube"
    }
}

extension Recipie {
    static func mocked() -> [Recipie] {
        [
            Recipie(id: "321", name: "Oxtail with broad beans", category: "Beef", cusine: "Jamaican", instructions: "Toss the oxtail with the onion, spring onion, garlic, ginger, chilli, soy sauce, thyme, salt and pepper. Heat the vegetable oil in a large frying pan over medium-high heat. Brown the oxtail in the pan until browned all over, about 10 minutes. Place into a pressure cooker, and pour in 375ml water. Cook at pressure for 25 minutes, then remove from heat, and remove the lid according to manufacturer's directions.\r\nAdd the broad beans and pimento berries, and bring to a simmer over medium-high heat. Dissolve the cornflour in 2 tablespoons water, and stir into the simmering oxtail. Cook and stir a few minutes until the sauce has thickened, and the broad beans are tender.", thumbnail: "https://www.themealdb.com/images/media/meals/1520083578.jpg", youtubeLink: "https://www.youtube.com/watch?v=DIhxk-98Hz8")
        ]
    }
}
