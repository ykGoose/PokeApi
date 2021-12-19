import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var fetchingActivityIndicatorView: UIActivityIndicatorView!
    
    func configure(with pokemon: Species?) {
        fetchingActivityIndicatorView.hidesWhenStopped = true
        fetchingActivityIndicatorView.startAnimating()
        pokemonNameLabel.text = pokemon?.pokemonSpecies.name.capitalized
        
        
        NetworkManager.shared.fetchImage(from: pokemon) { image in
            self.fetchingActivityIndicatorView.stopAnimating()
            self.pokemonImageView.image = image
        }

    }
}

