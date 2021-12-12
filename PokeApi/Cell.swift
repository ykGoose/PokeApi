//
//  PokemonCollectionViewCell.swift
//  PokeApi
//
//  Created by Владимир Падусов on 30.11.2021.
//

import UIKit
import SVGKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var pokemonImageView: UIImageView!
    
    @IBOutlet var pokemonNameLabel: UILabel!
    
    

    
    
    
    func configure(with pokemon: Species?) {
        pokemonNameLabel.text = pokemon?.pokemon_species.name.capitalized
        guard var pokeNumber = pokemon?.pokemon_species.url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "") else { return }
        pokeNumber.removeLast()
        print("\(pokemonNameLabel.text ?? "noname") - \(pokeNumber)")
        
        let imageURL = "\(URLsEnumeration.image.rawValue)\(pokeNumber).svg"
        
        guard let url = URL(string: imageURL) else { return self.pokemonImageView.image = .strokedCheckmark}
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data, let image = SVGKImage(data: data) {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image.uiImage
                }
            }
        }.resume()

}
}

