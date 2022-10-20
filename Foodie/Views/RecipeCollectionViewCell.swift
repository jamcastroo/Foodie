//
//  RecipeCollectionViewCell.swift
//  Foodie
//
//  Created by Jamile Castro on 16/10/22.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var recipeImage: UIImageView!
    var imagePath: String? {
        // Quando esse path é atribuido, fazemos então o download da imagem
        didSet {
            // Quando começamos a tentar mudar a imagem colocaremos um indicador de atividade
            activityIndicator.startAnimating()
            guard let path = imagePath else { return }
            Task {
                let image = await FreeMealDBService().getImageFrom(path: path)
                DispatchQueue.main.async {
                    // Quando já temos a imagem, removemos o indicador de atividade
                    self.activityIndicator.stopAnimating()
                    self.recipeImage.image = image
                }
            }
        }
    }
    
    // Essa função nos permite zerar o conteudo da collection para que imagens e texto antigo não fique em novas celulas
    override func prepareForReuse() {
        recipeImage.image = nil
        recipeTitle.text = nil
    }
}
